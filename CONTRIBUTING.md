# 🤝 Contributing to bearded-nvim

Thanks for your interest! This project mirrors the upstream VS Code Bearded Theme palettes and ships a Neovim colorscheme with integrations.

## Workflow

- 🧭 Clone the upstream VS Code theme to pull palettes: <https://github.com/BeardedBear/bearded-theme>
- 🌉 Point `BEARDED_THEME_PATH` to that clone when regenerating.
- 🔄 Regenerate palettes/stubs when upstream changes:

  ```bash
  BEARDED_THEME_PATH=/path/to/bearded-theme ./scripts/regen.sh
  ```

- 🧹 Format Lua:

  ```bash
  stylua .
  ```

- 🧪 Smoke test (headless load):

  ```bash
  ./scripts/smoke.sh
  ```

## PR checklist

- [ ] 🔄 Palettes regenerated if upstream changed
- [ ] 🧹 Stylua clean
- [ ] 🧪 Smoke test passes
- [ ] 📝 Highlight changes documented in the PR

## Reporting issues

- 🐛 Include Neovim version (`nvim --version`), flavor slug, and screenshots if it’s a visual issue.

## Requirements

- 🐍 Python 3 (for palette export/generation)
- 🛰️ Neovim in PATH (for `scripts/smoke.sh`)
- 🧹 Stylua (formatter)
- 🌉 Access to the upstream repo (cloned locally) for palette regeneration

## License

- 📝 GPL-3.0-only (see LICENSE)
