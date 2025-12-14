import { readFile, writeFile } from "fs/promises";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const root = path.resolve(__dirname, "..");
const upstreamBridge = path.resolve(root, "../bearded-theme/bridge.json");
const output = path.resolve(root, "lua/bearded/palettes/generated.lua");

/**
 * Simple serializer for plain objects/arrays -> Lua tables.
 */
function toLua(value, depth = 0) {
  const pad = "  ".repeat(depth);
  if (Array.isArray(value)) {
    const inner = value.map((v) => toLua(v, depth + 1)).join(", ");
    return `{ ${inner} }`;
  }

  if (value && typeof value === "object") {
    const entries = Object.entries(value)
      .sort(([a], [b]) => a.localeCompare(b))
      .map(([k, v]) => `${"  ".repeat(depth + 1)}${formatKey(k)} = ${toLua(v, depth + 1)}`)
      .join(",\n");
    return `{\n${entries}\n${pad}}`;
  }

  if (typeof value === "string") {
    return `"${value.replace(/\\/g, "\\\\").replace(/"/g, '\\"')}"`;
  }

  return String(value);
}

function formatKey(key) {
  // Preserve non-identifier keys by quoting
  if (/^[A-Za-z_][A-Za-z0-9_]*$/.test(key)) {
    return key;
  }
  return `["${key.replace(/"/g, '\\"')}"]`;
}

async function main() {
  const bridgeRaw = await readFile(upstreamBridge, "utf8");
  const bridge = JSON.parse(bridgeRaw);

  const palettes = bridge.map((item) => ({
    name: item.name,
    slug: item.slug,
    ui_theme: item.uiTheme,
    colors: item.theme.colors,
    levels: item.theme.levels,
    ui: item.theme.ui,
  }));

  const luaBody = palettes
    .map(
      (p) =>
        `  ["${p.slug}"] = ${toLua({
          name: p.name,
          ui_theme: p.ui_theme,
          colors: p.colors,
          levels: p.levels,
          ui: p.ui,
        })}`,
    )
    .join(",\n\n");

  const lua = `-- Auto-generated from ../bearded-theme/bridge.json\n-- Run: node scripts/export-palettes.mjs\nreturn {\n${luaBody}\n}\n`;

  await writeFile(output, lua, "utf8");
  console.log(`Wrote ${palettes.length} palettes to ${path.relative(root, output)}`);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
