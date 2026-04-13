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

## Text Objects

Used with operators (`d`, `c`, `y`, `v`, etc.)

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `af`/`if` | n,v,o | Function call | mini.ai built-in |
| `aF`/`iF` | n,v,o | Function (treesitter) | mini.ai |
| `ao`/`io` | n,v,o | Block/conditional/loop | mini.ai |
| `ad`/`id` | n,v,o | Digits | mini.ai |
| `ae`/`ie` | n,v,o | Word with case (camelCase) | mini.ai |
| `ai`/`ii` | n,v,o | Indent scope | mini.indentscope |
| `an`/`in` | v | Treesitter node (expand/shrink) | nvim 0.12 |
| `gh` | n,v,o | Diff hunk range | mini.diff |
| `sa` | n,v | Add surround | mini.surround |
| `sd` | n | Delete surround | mini.surround |
| `sr` | n | Replace surround | mini.surround |
| `sf`/`sF` | n | Find surround right/left | mini.surround |
| `sh` | n | Highlight surround | mini.surround |

## Motions

### (/) Motions (`(` = prev, `)` = next)

> `(` and `)` are motion prefixes in normal mode, replacing `[`/`]` bracket motions.
> `((` = line start, `))` = line end.

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `(f`/`)f` | n,x,o | Prev/next function | treesitter-textobjects |
| `(o`/`)o` | n,x,o | Prev/next block | treesitter-textobjects |
| `(h`/`)h` | n | Prev/next diff hunk | mini.diff |
| `(H`/`)H` | n | First/last diff hunk | mini.diff |
| `(d`/`)d` | n | Prev/next diagnostic | lsp |
| `(c`/`)c` | n,x,o | Prev/next comment | mini.bracketed |
| `(x`/`)x` | n,x,o | Prev/next conflict | mini.bracketed |
| `(i`/`)i` | n,x,o | Prev/next indent | mini.bracketed |
| `(l`/`)l` | n,x,o | Prev/next location | mini.bracketed |
| `(q`/`)q` | n,x,o | Prev/next quickfix | mini.bracketed |
| `(s` | n | Go to treesitter context | treesitter-context |
| `(t`/`)t` | n | Prev/next failed test | neotest |
| `({`/`)}` | n,x,o | Prev/next unmatched `{`/`}` | vim `[{`/`]}` |
| `((`/`))` | n,x,o | Prev/next unmatched `(`/`)` | vim `[(`/`])` |

### Edge Navigation

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `g[` + object | n,v,o | Jump to left edge | mini.ai |
| `g]` + object | n,v,o | Jump to right edge | mini.ai |

## Keymaps

Leader key: `,`

### General

| Key | Mode | Description |
|-----|------|-------------|
| `<Esc>` | n | Clear hlsearch |
| `'` | n,x,o | Reverse char search (`;` forward, `'` backward) |
| `X` | n | Close float or quit |
| `H` / `L` | n,x,o | Begin/end of line (`^`/`$`) |
| `K` | n | Hover (neovim default) |
| `M` | n | Middle of screen (vim default) |
| `J` | n | Join lines |
| `S` | n | Split line |
| `D` | n | Delete to EOL |
| `j` / `k` | n | Down/up (wrapped lines) |
| `*` / `#` | n | Search word forward/backward |
| `n` / `N` | n | Next/prev match (centered) |
| `c*` / `c#` | n | Change word forward/backward |
| `g;` / `g,` | n | Prev/next change (centered) |
| `<C-i>` / `<C-o>` | n | Jump forward/backward (centered) |
| `<` / `>` | v | Indent left/right (stay visual) |
| `.` | x | Dot repeat in visual |
| `Q` | x | Run macro on selection |
| `<C-j>` | i | Uppercase word |

### Clipboard

| Key | Mode | Description |
|-----|------|-------------|
| `y` | n,x | Copy to clipboard |
| `Y` | n | Copy to EOL |
| `yy` | n | Copy line |
| `gp` | n,x | Paste from clipboard |
| `gV` | n | Select changed text |

### Save

| Key | Mode | Description |
|-----|------|-------------|
| `<C-S>` | n,i,x | Save |
| `,w` | n | Write all buffers |

### Diff Merge

| Key | Mode | Description |
|-----|------|-------------|
| `,1` | n | Diffget LOCAL |
| `,2` | n | Diffget BASE |
| `,3` | n | Diffget REMOTE |

### Picker (snacks)

| Key | Mode | Description |
|-----|------|-------------|
| `<C-f>` | n | Find files |
| `<C-p>` | n | Find files (project root) |
| `<C-h>` | n | Resume picker |
| `<C-,>` | n | All pickers |
| `,b` | n | Buffers |
| `,g` | n | Grep |
| `,/` | n | Grep current buffer |
| `,o` | n | Projects |
| `,z` | n | Zoxide |
| `,m` | n | Marks |
| `,j` | n | Jumps |
| `,:` | n | Command history |
| `,<leader>` | n | Alternate buffer |

### Git (snacks)

| Key | Mode | Description |
|-----|------|-------------|
| `,kk` | n | LazyGit |
| `,kd` | n | Git diff hunks |
| `,kl` | n | Git blame line |
| `,ku` | n | Git browse URL |
| `,km` | n | Keymaps |
| `gh` | n,v,o | Apply diff hunk |
| `gH` | n,v,o | Reset diff hunk |

### LSP

| Key | Mode | Description |
|-----|------|-------------|
| `gd` | n | Definition |
| `gD` | n | Declaration |
| `gt` | n | Type definition |
| `gii` | n | Implementation |
| `gr` | n | References |
| `gic` | n | Incoming calls |
| `goc` | n | Outgoing calls |
| `gwa` | n | Add workspace folder |
| `gwr` | n | Remove workspace folder |
| `gwl` | n | List workspace folders |
| `gws` | n | Workspace symbols |
| `<Space>r` | n | Rename |
| `<Space>a` | n | Code action |
| `<Space>s` | n | Document symbols |
| `<Space>S` | n | Signature help |
| `<Space>f` | n | Format |
| `<Space>x` | n | Codelens |
| `<Space>d` | n | Diagnostic float |
| `<Space>D` | n | Buffer diagnostics |
| `<Space>t` | n | Todo quickfix |

### Test (neotest)

| Key | Mode | Description |
|-----|------|-------------|
| `,tr` | n | Run nearest |
| `,tf` | n | Run file |
| `,ts` | n | Summary |
| `,to` | n | Output |
| `,tp` | n | Output panel |
| `,td` | n | Debug nearest |
| `,tl` | n | Run last |

### UI Toggles (snacks)

| Key | Mode | Description |
|-----|------|-------------|
| `,us` | n | Toggle spelling |
| `,uw` | n | Toggle wrap |
| `,ul` | n | Toggle relative number |
| `,uL` | n | Toggle line number |
| `,ud` | n | Toggle diagnostics |
| `,uc` | n | Toggle conceal |
| `,ui` | n | Toggle inlay hints |
| `,ut` | n | Toggle treesitter context |
| `,uu` | n | Undo history |
| `,uh` | n | Notification history |
| `,un` | n | Dismiss notifications |

### File Manager (yazi)

| Key | Mode | Description |
|-----|------|-------------|
| `,e` | n | Open at cwd |
| `,y` | n | Resume session |

### AI (codecompanion)

| Key | Mode | Description |
|-----|------|-------------|
| `,i` | n | Chat |
| `,a` | n | Actions |

### Misc

| Key | Mode | Description |
|-----|------|-------------|
| `,r` | n | Find and replace |
| `<C-q>` | n | Toggle quickfix |
| `<F2>` | n | Trim whitespace |
| `<F3>` | n | Undotree |
| `<F4>` | n | Toggle outline |
| `ga` | n,v | Easy align |
| `gj` / `gs` | n | Join/split node |
| `gc` / `gcc` | n,v | Comment toggle |

### Window Navigation (smart-splits)

| Key | Mode | Description |
|-----|------|-------------|
| `<A-h/j/k/l>` | n | Move between splits |
| `<A-S-h/j/k/l>` | n | Resize splits |

## Keys Free

### Uppercase Letters

| Key | Mode | Note |
|-----|------|------|
| `R` | n | Built-in: replace mode (niche, keep in visual for block replace) |
| `U` | n | Built-in: undo whole line (niche, keep in visual for uppercase) |

### Leader (`,`)

| Key | Mode | Note |
|-----|------|------|
| `,c` | n,v | |
| `,d` | n | Freed from buffer diagnostics (now `<Space>D`) |
| `,f` | n | |
| `,h` | n | |
| `,l` | n | |
| `,n` | n | |
| `,p` | n,v | |
| `,q` | n | Freed from quickfix toggle (now `<C-q>`) |
| `,s` | n | Freed from document symbols (now `<Space>s`) |
| `,v` | n | |
| `,x` | n,v | |

### Ctrl (built-in is niche)

| Key | Mode | Note |
|-----|------|------|
| `<C-n>` | n | Built-in: down (redundant with `j`), used for list scrolling in picker/completion |
| `<C-g>` | n | Built-in: file info (`:f` or `g<C-g>` also work) |
| `<C-l>` | n | Built-in: redraw screen (rarely needed) |
| `<C-t>` | n | Built-in: older tag jump (redundant with `<C-o>` via LSP) |
| `<C-j>` | n | Built-in: down/enter (redundant with `j`/`<CR>`, used in cmdline for history) |
| `<C-z>` | n | Built-in: suspend vim (niche) |

### Ctrl (kitty-exclusive)

| Key | Mode | Note |
|-----|------|------|
| `<C-m>` | n,i | Kitty distinguishes from Enter |
| `<C-;>` | n,i | No built-in |
| `<C-.>` | n,i | No built-in |
| `<C-/>` | n,i | No built-in |
| `<C-1>` to `<C-9>` | n | No built-in |

## Colorscheme

Three variants: `mdk-base16` (full), `mdk-base8` (reduced), `mdk-base4` (minimal).
Palette source of truth: [`colors/mdk-base16.lua`](colors/mdk-base16.lua).

[Preview](https://htmlpreview.github.io/?https://github.com/mdk194/nvim/blob/main/colorscheme.html) — palette swatches, code highlighting (Rust, Python, Go, TypeScript), terminal session, git diff.

### Terminal configs

- [`kitty.terminal`](kitty.terminal) — kitty 16 ANSI colors, foreground, background, cursor
- [`git.terminal`](git.terminal) — git status, diff, delta colors
- [`dir_colors.terminal`](dir_colors.terminal) — ls/grep truecolor output (load via `eval $(dircolors dir_colors.terminal)`)
- `export GREP_COLORS='mt=1;7;33'` — grep matched text: bold reverse yellow (kitty color3)

## Go

- Run `:GoInstallDeps`

