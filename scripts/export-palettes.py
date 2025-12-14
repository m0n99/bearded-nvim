#!/usr/bin/env python3
import json
import os
from pathlib import Path


ROOT = Path(__file__).resolve().parent.parent
# Allow overriding upstream path; default expects ../bearded-theme checked out locally.
UPSTREAM = (
    Path(os.environ["BEARDED_THEME_PATH"])
    if "BEARDED_THEME_PATH" in os.environ
    else ROOT.parent / "bearded-theme"
)
BRIDGE = UPSTREAM / "bridge.json"
OUTPUT = ROOT / "lua" / "bearded" / "palettes" / "generated.lua"


def format_key(key: str) -> str:
    if key.isidentifier():
        return key
    escaped = key.replace('"', r"\"")
    return f'["{escaped}"]'


def to_lua(value, depth: int = 0) -> str:
    pad = "  " * depth
    if isinstance(value, dict):
        entries = []
        for k in sorted(value.keys()):
            entries.append(f'{"  " * (depth + 1)}{format_key(k)} = {to_lua(value[k], depth + 1)}')
        inner = ",\n".join(entries)
        return "{\n" + inner + f"\n{pad}" + "}"
    if isinstance(value, (list, tuple)):
        inner = ", ".join(to_lua(item, depth + 1) for item in value)
        return "{ " + inner + " }"
    if isinstance(value, str):
        escaped = value.replace("\\", "\\\\").replace('"', r"\"")
        return f'"{escaped}"'
    return str(value)


def main() -> None:
    if not BRIDGE.exists():
        raise SystemExit(
            f"bridge.json not found at {BRIDGE} (set BEARDED_THEME_PATH to the upstream checkout)"
        )

    bridge = json.loads(BRIDGE.read_text("utf-8"))
    palettes = [
        {
            "slug": item["slug"],
            "name": item["name"],
            "ui_theme": item["uiTheme"],
            "colors": item["theme"]["colors"],
            "levels": item["theme"]["levels"],
            "ui": item["theme"]["ui"],
        }
        for item in bridge
    ]

    body = []
    for palette in palettes:
        lua_table = to_lua(
            {
                "name": palette["name"],
                "ui_theme": palette["ui_theme"],
                "colors": palette["colors"],
                "levels": palette["levels"],
                "ui": palette["ui"],
            }
        )
        body.append(f'  ["{palette["slug"]}"] = {lua_table}')

    lua = (
        "-- Auto-generated from ../bearded-theme/bridge.json\n"
        "-- Run: python3 scripts/export-palettes.py\n"
        "return {\n"
        + ",\n\n".join(body)
        + "\n}\n"
    )

    OUTPUT.write_text(lua, encoding="utf-8")
    print(f"Wrote {len(palettes)} palettes to {OUTPUT.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
