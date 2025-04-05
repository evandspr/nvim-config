# My Nvim configuration

My personal Nvim config. I designed it to be lightweight, efficient, and that it meets all my needs.

## ⚙️ Prerequisites

*   [Neovim](https://neovim.io/) (version 0.9 or later)
*   A Nerd Font (I personnaly use [MesloLGS NF](https://github.com/romuloogc/meslo-lgs-nerd-font) - other Nerd Fonts will also work)
*   A terminal with true color support (I use Windows Terminal + WSL)

## 🔌 Plugins

This configuration uses the following plugins, managed by Lazy.nvim:

*   [tpope/vim-sleuth](https://github.com/tpope/vim-sleuth): Automatically detects indentation settings.
*   [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons): Provides icons for NvimTree, Telescope, etc...
*   [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua): A file explorer.
*   [vim-airline/vim-airline](https://github.com/vim-airline/vim-airline): A statusline plugin.
*   [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim): Displays Git signs in the gutter.
*   [folke/which-key.nvim](https://github.com/folke/which-key.nvim): Displays available keybindings.
*   [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim): A fuzzy finder.
*   [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig): Language Server Protocol support.
*   [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim): Auto-formatting.
*   [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp): Autocompletion.
*   [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim): Highlights TODO, FIXME, etc., comments.
*   [echasnovski/mini.nvim](https://github.com/echasnovski/mini.nvim): A collection of useful mini plugins.
*   [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): Improved syntax highlighting and more.
*   [Diogo-ss/42-header.nvim](https://github.com/Diogo-ss/42-header.nvim): Plugin for managing 42 headers.
*   [hardyrafael17/norminette42.nvim](https://github.com/hardyrafael17/norminette42.nvim): Plugin for running norminette (42 standard).
*   [sakhnik/nvim-gdb](https://github.com/sakhnik/nvim-gdb): Plugin for integrating GDB, LLDB, etc...
*   [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim): Plugin for commenting/uncommenting code.
*   [numToStr/FTerm.nvim](https://github.com/numToStr/FTerm.nvim): Floating terminal.
*   [mg979/vim-visual-multi](https://github.com/mg979/vim-visual-multi): Plugin for multiple selections/edits.
*   [folke/noice.nvim](https://github.com/folke/noice.nvim): Redefining the UI
*   [folke/lazydev.nvim](https://github.com/folke/lazydev.nvim): Plugin to Improve the lua development of nvim configuration
*   [3rd/image.nvim](https://github.com/3rd/image.nvim): Plugin to Open images files
	*   [b0o/nvim-tree-preview.lua](https://github.com/b0o/nvim-tree-preview.lua): Plugin to Open Previews files
	*   [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim): Plugin usefuls lua utils
*   (plus several dependencies of the above)

## 🎨 Colorscheme

*   [eldritch-theme/eldritch.nvim](https://github.com/Eldritch-theme/eldritch.nvim): A dark colorscheme that provides a consistent UI.

## ⌨️ Keybindings

| Keybinding   | Description                                                   |
| :----------- | :------------------------------------------------------------ |
| `<leader>q`  | Open diagnostic Quickfix list                                 |
| `<C-Left>`   | Move focus to the left window                                 |
| `<C-Right>`  | Move focus to the right window                                |
| `<Esc>`      | Clear search highlights                                         |
| `<leader>e`  | Toggle NvimTree                                               |
| `<S-h>`      | Telescope Buffers                                             |
| `<leader>n`  | Open Vertical Split New File                                    |
| `<C-/>`       | Comment/Uncomment single lines/blocks                           |
| `<leader>cb` | Comment the selected block of text                              |
| `<leader>N`  | Run norminette on current file                                |
| `<leader>F`  | Find .c files and append to Makefile                          |
| `<leader>d`  | Start LLDB for debugging                                      |
| `<leader>mm` | Make project                                                  |
| `<leader>mc` | Clean project                                                 |
| `<leader>mf` | Force Clean project                                             |
| `<leader>mr` | Rebuild project                                               |
| `<leader>mn` | Run norminette                                                |
| `P`          | Preview (Watch) [NvimTree]                                      |
| `<Esc>`      | Close Preview/Unwatch [NvimTree]                                  |
| `<Tab>`      | Toggle focus between NvimTree and preview                       |
| `<C-f>`      | Scroll Down (preview window)                                    |
| `<C-b>`      | Scroll Up (preview window)                                      |

## 💡 Contact

If you have any questions or need help with this configuration, feel free to contact me at <edesprez@student.42.fr>.

---

**edesprez**  
42 Student @ Paris
