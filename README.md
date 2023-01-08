# Install

- Start nvim, lazy will auto install plugins
- Run `:MasonToolsInstall` to install lsp servers

## Icons

- Download and install nerd fonts symbols:

  ```bash
  # https://github.com/ryanoasis/nerd-fonts/wiki/Glyph-Sets-and-Code-Points
  # https://www.nerdfonts.com/cheat-sheet
  curl https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/NerdFontsSymbolsOnly.zip
  unzip NerdFontsSymbolsOnly.zip
  cp 'Symbols-2048-em Nerd Font Complete Mono.ttf' ~/.local/share/fonts/
  fc-cache -rfv
  ```

- Put these to `kitty.conf`:

  ```
  # Seti-UI + Custom
  symbol_map U+E5FA-U+E62B Symbols Nerd Font Mono
  # Devicons
  symbol_map U+E700-U+E7C5 Symbols Nerd Font Mono
  # Font Awesome
  symbol_map U+F000-U+F2E0 Symbols Nerd Font Mono
  # Font Awesome Extension
  symbol_map U+E200-U+E2A9 Symbols Nerd Font Mono
  # Material Design Icons
  symbol_map U+F500-U+FD46 Symbols Nerd Font Mono
  # Weather
  symbol_map U+E300-U+E3EB Symbols Nerd Font Mono
  # Octicons
  symbol_map U+F400-U+F4A8,U+2665,U+26A1,U+F27C Symbols Nerd Font Mono
  # Powerline Symbols
  symbol_map U+E0A0-U+E0A2,U+E0B0-U+E0B3
  # Powerline Extra Symbols
  symbol_map U+E0A3,U+E0B4-U+E0C8,U+E0CC-U+E0D2,U+E0D4 Symbols Nerd Font Mono
  # IEC Power Symbols
  symbol_map U+23FB-U+23FE,U+2b58 Symbols Nerd Font Mono
  # Font Logos
  symbol_map U+F300-U+F313 Symbols Nerd Font Mono
  # Pomicons
  symbol_map U+E000-U+E00D Symbols Nerd Font Mono
  # Codicons
  symbol_map U+EA60-U+EBEB Symbols Nerd Font Mono
  ```

## Vale

- Create a default configuration file at `$HOME/.vale.ini`:

  ```ini
  StylesPath = styles

  MinAlertLevel = suggestion

  Packages = Google, proselint, write-good

  [*]
  BasedOnStyles = Vale, Google, proselint, write-good
  ```

## Go

- Run `:GoInstallDeps`

## Java

- Some manual steps needed, check details in `ftplugin/java.lua`
