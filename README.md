# Install

- Start nvim, lazy will auto install plugins
- Run `:MasonToolsInstall` to install lsp servers

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
