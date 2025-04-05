-- Configuration centralisée des plugins
-- Retourne la table de configuration pour lazy.nvim

return {
  -- UI et Thémes
  {
    'eldritch-theme/eldritch.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      require('eldritch').setup {
        transparent = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
        },
      }
    end,
  },

  -- Barre de statut
  {
    'vim-airline/vim-airline',
    event = 'VimEnter',
    dependencies = { 'vim-airline/vim-airline-themes' },
    config = function()
      require('plugins.airline')
    end,
  },
  'vim-airline/vim-airline-themes',

  -- Explorateur de fichiers
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'b0o/nvim-tree-preview.lua',
      'nvim-lua/plenary.nvim',
      '3rd/image.nvim',
    },
    cmd = 'NvimTreeToggle',
    config = function()
      require('plugins.nvimtree')
    end,
  },

  -- Git
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('plugins.gitsigns')
    end,
  },

  -- Aide aux raccourcis
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('plugins.whichkey')
    end,
  },

  -- Recherche avancée
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-telescope/telescope-ui-select.nvim',
    },
    event = 'VimEnter',
    config = function()
      require('plugins.telescope')
    end,
  },

  -- LSP et complétion
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'j-hui/fidget.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-cmdline',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('plugins.lsp')
    end,
  },

  -- Formatage
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = 'Format buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return
        end
        return { timeout_ms = 500, lsp_format = 'fallback' }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        javascript = { 'prettierd', 'prettier' },
        typescript = { 'prettierd', 'prettier' },
      },
    },
  },

  -- Autocomplétion
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = (vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0) and nil or 'make install_jsregexp',
        dependencies = {
          'rafamadriz/friendly-snippets',
          'zbirenbaum/copilot.lua',
        },
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-cmdline',
    },
    config = function()
      require('plugins.cmp')
    end,
  },

  -- Treesitter pour syntaxe améliorée
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('plugins.treesitter')
    end,
  },

  -- En-têtes 42
  {
    'Diogo-ss/42-header.nvim',
    lazy = false,
    opts = {
      default_map = true,
      auto_update = true,
      user = 'edesprez',
      mail = 'edesprez@student.42.fr',
    },
  },

  -- Norminette 42
  {
    'hardyrafael17/norminette42.nvim',
    ft = { 'c', 'h' },
    cmd = { 'Norminette', 'Header42', 'NorminetteEnable', 'NorminetteDisable' },
    opts = {
      runOnSave = true,
      active = true,
    },
    keys = {
      { '<leader>nh', '<cmd>Header42<CR>', desc = 'Norminette Header' },
    },
  },

  -- Debugger
  {
    'sakhnik/nvim-gdb',
    run = './install.sh',
    ft = { 'c', 'cpp' },
    cmd = {
      'GdbStart', 'GdbAttach', 'GdbBreak', 'GdbContinue', 'GdbRun',
      'GdbNext', 'GdbStep', 'GdbFinish', 'GdbInfo', 'GdbPrint',
    },
    opts = {},
  },

  -- Commentaires
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    opts = {
      mappings = {
        basic = true,
        extra = false,
      },
    },
  },

  -- Terminal flottant
  {
    'numToStr/FTerm.nvim',
    event = 'VeryLazy',
    opts = {
      border = 'double',
      dimensions = {
        height = 0.9,
        width = 0.9,
      },
    },
    keys = {
      {
        '<leader>ft',
        function()
          require('FTerm').toggle()
        end,
        desc = 'Toggle Floating Terminal',
      },
    },
  },

  -- Sélection multiple
  {
    'mg979/vim-visual-multi',
    event = 'VeryLazy',
    init = function()
      vim.g.VM_leader = '\\'
    end,
  },

  -- UI améliorée
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    config = function()
      require('plugins.noice')
    end,
  },

  -- Utilitaires
  {
    'echasnovski/mini.nvim',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
    end,
  },

  -- TODO highlights
  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  -- Dépendances et utilitaires généraux
  'nvim-lua/plenary.nvim',
  'nvim-tree/nvim-web-devicons',
  'b0o/nvim-tree-preview.lua',
  '3rd/image.nvim',
  'tpope/vim-sleuth',

  -- Développement de la configuration
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = '${rtp}/lua' },
        { path = '${rtp}/lua/vim/lsp' },
      },
    },
  },
} 