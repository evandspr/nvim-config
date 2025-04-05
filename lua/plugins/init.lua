-- Fichier: lua/plugins/init.lua
-- Retourne la table de configuration des plugins pour lazy.nvim

return {
  -- Détection automatique de l'indentation
  'tpope/vim-sleuth',

  -- Icônes (dépendance pour nvim-tree, telescope, etc.)
  { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },

  -- Explorateur de fichiers NvimTree
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'b0o/nvim-tree-preview.lua',
      'nvim-lua/plenary.nvim',
      '3rd/image.nvim',
    },
    cmd = 'NvimTreeToggle', -- Charge le plugin quand la commande est appelée
    opts = { -- Utilise 'opts' pour passer la config à la fonction setup de nvim-tree
      disable_netrw = true,
      hijack_netrw = true,
      view = {
        width = 35,
        side = 'left',
      },
      renderer = {
        icons = {
          glyphs = {
            default = '󰈚',
            symlink = '',
            folder = {
              default = '󰉋',
              open = '󰉌',
              empty = '󰉖',
              empty_open = '󰉗',
              symlink = '󰉒',
              symlink_open = '󰉓',
            },
            git = {
              unstaged = '󰄱',
              staged = '󰱒',
              unmerged = '󰘬',
              renamed = '󰰾',
              untracked = '󰎗',
              deleted = '󰍵',
              ignored = '󰷊',
            },
          },
        },
      },
      actions = {
        open_file = {
          quit_on_open = false, -- Garde NvimTree ouvert après l'ouverture d'un fichier
        },
      },
      -- Fonction on_attach pour les mappings spécifiques à NvimTree
      on_attach = function(bufnr)
        local api = require 'nvim-tree.api'
        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        local preview = require 'nvim-tree-preview'

        vim.keymap.set('n', 'P', preview.watch, opts 'Preview (Watch)')
        vim.keymap.set('n', '<Esc>', preview.unwatch, opts 'Close Preview/Unwatch')
        vim.keymap.set('n', '<C-f>', function()
          return preview.scroll(4)
        end, opts 'Scroll Down')
        vim.keymap.set('n', '<C-b>', function()
          return preview.scroll(-4)
        end, opts 'Scroll Up')

        -- Option A: Smart tab behavior: Only preview files, expand/collapse directories (recommended)
        vim.keymap.set('n', '<Tab>', function()
          local ok, node = pcall(api.tree.get_node_under_cursor)
          if ok and node then
            if node.type == 'directory' then
              api.node.open.edit()
            else
              preview.node(node, { toggle_focus = true })
            end
          end
        end, opts 'Preview')

        -- Mappe 'T' pour ouvrir dans un nouvel onglet DANS NvimTree
        vim.keymap.set('n', 'T', api.node.open.tab, opts 'Open in New Tab')
        vim.keymap.set('n', '<CR>', api.node.open.edit, opts 'Open / Edit')
        -- Ajoute d'autres mappings si tu veux (ex: 's' split vertical, 'v' horizontal)
        vim.keymap.set('n', 's', api.node.open.vertical, opts 'Open: Vertical Split')
        -- vim.keymap.set('n', 'v', api.node.open.horizontal, opts('Open: Horizontal Split'))
      end,
    },
  },

  -- Barre de statut Airline (Migré depuis vim-plug)
  {
    'vim-airline/vim-airline',
    event = 'VimEnter', -- Charger après le démarrage complet
    dependencies = { 'vim-airline/vim-airline-themes' },
    config = function()
      vim.g['airline#extensions#tabline#enabled'] = 1
      -- Autres configurations Airline si nécessaire
      -- vim.g.airline_theme = 'eldritch' -- exemple si un thème airline existe
    end,
  },
  'vim-airline/vim-airline-themes', -- Thèmes pour Airline (chargé comme dépendance)

  -- GitSigns (indicateurs Git dans la gouttière)
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' }, -- Charger quand on ouvre un fichier
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- WhichKey (affiche les raccourcis possibles)
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or { -- Utilise les icônes Nerd Font si disponibles
          ['<CR>'] = '↵',
          ['<Esc>'] = '⎋',
          ['<Space>'] = '␣',
          ['<Tab>'] = '⇥', -- etc.
        },
      },
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        -- Ajoute tes propres groupes ici si nécessaire
      },
    },
  },

  -- Telescope (Fuzzy finder)
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      -- nvim-web-devicons est déjà listé plus haut
    },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- Mappings Telescope (gardés ici car spécifiques à Telescope)
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false })
      end, { desc = '[/] Fuzzily search in current buffer' })
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }
      end, { desc = '[S]earch [/] in Open Files' })
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- Configuration LSP (Language Server Protocol)
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', opts = {} }, -- Gestionnaire d'installation LSP/outils
      'williamboman/mason-lspconfig.nvim', -- Pont entre mason et lspconfig
      'WhoIsSethDaniel/mason-tool-installer.nvim', -- Pour assurer l'installation d'outils
      { 'j-hui/fidget.nvim', opts = {} }, -- Indicateur de statut LSP
      'hrsh7th/cmp-nvim-lsp', -- Source LSP pour nvim-cmp
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = { -- Configure les serveurs LSP que tu veux utiliser
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
        -- Ajoute d'autres serveurs ici (ex: 'pyright', 'tsserver', 'gopls', 'clangd')
        -- pyright = {},
        -- tsserver = {},
      }

      -- Assure l'installation des serveurs et outils via Mason
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Formatteur Lua (utilisé par conform.nvim)
        -- Ajoute d'autres outils ici (ex: 'prettier', 'eslint_d', 'black', 'isort')
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      -- Configure lspconfig pour utiliser les serveurs installés par Mason
      require('mason-lspconfig').setup {
        ensure_installed = {}, -- mason-tool-installer s'en occupe
        automatic_installation = false,
        handlers = {
          function(server_name) -- Configuration par défaut pour chaque serveur
            local server_opts = servers[server_name] or {}
            server_opts.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server_opts.capabilities or {})
            require('lspconfig')[server_name].setup(server_opts)
          end,
        },
      }

      -- Configuration des diagnostics (erreurs, warnings)
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font
            and {
              text = {
                [vim.diagnostic.severity.ERROR] = ' ', -- Ex: Icônes Font Awesome
                [vim.diagnostic.severity.WARN] = ' ',
                [vim.diagnostic.severity.INFO] = ' ',
                [vim.diagnostic.severity.HINT] = '󰌶 ', -- Ex: Icône Nerd Font
              },
            }
          or { -- Fallback texte si pas de Nerd Font
            text = {
              [vim.diagnostic.severity.ERROR] = 'E>',
              [vim.diagnostic.severity.WARN] = 'W>',
              [vim.diagnostic.severity.INFO] = 'I>',
              [vim.diagnostic.severity.HINT] = 'H>',
            },
          },
        virtual_text = { source = 'if_many', spacing = 2 },
      }

      -- Autocommand pour configurer les mappings LSP lors de l'attachement
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Mappings LSP (définis ici pour être spécifiques au buffer)
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Surlignage des références sous le curseur
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method('textDocument/documentHighlight', { bufnr = event.buf }) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- Toggle Inlay Hints (si supporté par le LSP)
          if client and client.supports_method('textDocument/inlayHint', { bufnr = event.buf }) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })
    end,
  },

  -- Auto-formatage avec conform.nvim
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' }, -- Se déclenche avant d'écrire le buffer
    cmd = { 'ConformInfo' },
    keys = { -- Mapping pour formater manuellement
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr) -- Active le formatage à la sauvegarde
        -- Désactive pour certains types de fichiers si besoin
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return
        end
        return { timeout_ms = 500, lsp_format = 'fallback' }
      end,
      formatters_by_ft = { -- Définit les formatteurs par type de fichier
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        -- Ajoute d'autres langages et formatteurs ici
      },
    },
  },

  -- Autocomplétion avec nvim-cmp
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip', -- Moteur de snippets
        build = (vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0) and nil or 'make install_jsregexp', -- Build pour le support regex (sauf Windows/si make absent)
        dependencies = {
          -- Collection de snippets (optionnel, décommente si tu en veux)
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
          -- },
        },
      },
      'saadparwaiz1/cmp_luasnip', -- Source Luasnip pour nvim-cmp
      'hrsh7th/cmp-nvim-lsp', -- Source LSP (déjà listé comme dépendance de lspconfig mais on le redéclare ici pour cmp)
      'hrsh7th/cmp-path', -- Source pour les chemins de fichiers
      'hrsh7th/cmp-buffer', -- Source pour les mots du buffer actuel
      'hrsh7th/cmp-nvim-lsp-signature-help', -- Aide à la signature de fonction
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {} -- Setup de base pour Luasnip

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(), -- Forcer l'affichage des complétions
          ['<C-y>'] = cmp.mapping.confirm { select = true }, -- Confirmer la sélection
          -- Mappings pour Luasnip (navigation dans les snippets)
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
          -- Utiliser <CR> pour confirmer au lieu de <C-y> si tu préfères
          -- ['<CR>'] = cmp.mapping.confirm { select = true },
        },
        sources = cmp.config.sources({ -- Ordre des sources de complétion
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        }, {
          { name = 'buffer' },
          { name = 'nvim_lsp_signature_help' },
        }),
      }
    end,
  },

  -- Colorscheme Eldritch (Déplacé ici)
  {
    'eldritch-theme/eldritch.nvim',
    priority = 1000, -- Charger tôt pour que l'UI soit cohérente rapidement
    lazy = false, -- S'assurer qu'il est chargé au démarrage pour que `colors.lua` fonctionne
    config = function()
      require('eldritch').setup {
        transparent = true, -- Ton option
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          -- ... autres styles
        },
        -- ... autres options eldritch
      }
      -- La commande vim.cmd.colorscheme est maintenant dans lua/colors.lua
    end,
  },
  -- Alternative: Kanagawa (si tu préfères, décommente et commente eldritch)
  -- { 'rebelot/kanagawa.nvim', priority = 1000, lazy = false, config = function() vim.cmd.colorscheme 'kanagawa' end },

  -- Todo Comments (surlignage des TODO, FIXME, etc.)
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false }, -- Désactive les signes dans la gouttière si tu préfères
  },

  -- Mini.nvim (collection de petits modules utiles)
  {
    'echasnovski/mini.nvim',
    version = '*', -- Utilise la dernière version stable
    config = function()
      -- Mini.ai: Meilleurs textobjects a/i
      require('mini.ai').setup { n_lines = 500 }
      -- Mini.surround: Gérer les paires (quotes, parenthèses...)
      require('mini.surround').setup()
      -- Mini.statusline: Barre de statut simple
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
      statusline.section_location = function()
        return '%2l:%-2v'
      end -- Format LIGNE:COLONNE
    end,
  },

  -- Treesitter (Coloration syntaxique améliorée et plus)
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    event = { 'BufReadPre', 'BufNewFile' }, -- Charger tôt pour la coloration
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'javascript',
        'typescript',
        'python',
        'json',
        'yaml',
        'css',
        'scss',
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      -- Modules additionnels (exemples)
      -- incremental_selection = { enable = true, keymaps = { node_incremental = 'v', /* ... */ } }
      -- textobjects = { select = { enable = true, /* ... */ } }
    },
  },

  -- Plugin pour gérer les en-têtes 42
  {
    'Diogo-ss/42-header.nvim',
    lazy = false, -- On le charge au démarrage pour que <F1> fonctionne toujours
    -- cmd = { "Stdheader" }, -- 'lazy = false' rend cmd/keys moins pertinents pour le chargement initial, mais bon à garder pour info
    -- keys = { "<F1>" }, -- Idem
    opts = {
      default_map = true, -- Active le mapping par défaut <F1> en mode normal.
      auto_update = true, -- Met à jour l'en-tête à la sauvegarde.
      user = 'edesprez',
      mail = 'edesprez@student.42.fr',
      -- Tu peux ajouter d'autres options si besoin, voir la doc du plugin
    },
    config = function(_, opts)
      -- On s'assure que la fonction setup est appelée avec les options
      require('42header').setup(opts)
      -- Optionnel: si tu ne veux PAS le mapping par défaut <F1> mais un autre:
      -- vim.keymap.set('n', '<leader>42', '<cmd>Stdheader<CR>', { desc = 'Ajouter/Mettre à jour en-tête 42' })
    end,
  },

  {
    'hardyrafael17/norminette42.nvim',
    -- Gardons un trigger de chargement paresseux raisonnable
    ft = { 'c', 'h' }, -- Charger pour les fichiers C/H
    cmd = { 'Norminette', 'Header42', 'NorminetteEnable', 'NorminetteDisable' }, -- Charger si une de ces commandes est appelée
    -- Utiliser 'opts' pour passer la configuration.
    -- lazy.nvim appellera automatiquement require('norminette').setup(opts)
    -- Note bien : on utilise 'norminette' ici, comme dans la doc !
    opts = {
      runOnSave = true, -- Exécuter à la sauvegarde
      -- maxErrorsToShow = 5, -- Nombre max d'erreurs (décommente si besoin)
      active = true, -- Plugin actif par défaut
      -- path_to_norminette = nil, -- Spécifie un chemin si non standard
    },
    -- Définir le mapping via la clé 'keys' de lazy.nvim
    keys = {
      -- Tu peux aussi ajouter un mapping pour l'en-tête si tu veux
      { '<leader>nh', '<cmd>Header42<CR>', desc = '[N]orminette [H]eader' },
    },
    -- Pas besoin de la fonction 'config' explicite si on utilise 'opts' et que
    -- le point d'entrée principal est 'nom-du-plugin/init.lua' ou 'nom-du-plugin.lua'
    -- et qu'il attend la table 'opts' dans sa fonction setup.
    -- lazy.nvim s'occupe d'appeler require('norminette').setup(opts)
  },

  -- Plugin pour intégrer GDB
  {
    'sakhnik/nvim-gdb',
    -- IMPORTANT: Ce plugin nécessite une étape de compilation/installation
    run = './install.sh',
    -- Charger pour les fichiers C/C++ ou via les commandes GDB
    ft = { 'c', 'cpp' },
    cmd = {
      'GdbStart',
      'GdbStartLLDB',
      'GdbAttach',
      'GdbBreak',
      'GdbContinue',
      'GdbRun',
      'GdbNext',
      'GdbStep',
      'GdbFinish',
      'GdbInfo',
      'GdbPrint',
      'GdbEval',
      'GdbBacktrace',
      'GdbFrame',
      'GdbUp',
      'GdbDown',
      'GdbSetVar',
    },
    -- Aucune option de base requise pour le setup, mais tu peux en ajouter
    opts = {},
    -- Tu peux ajouter des mappings ici si tu le souhaites, par ex:
    -- keys = {
    --   { "<leader>db", "<cmd>GdbBreak<CR>", desc = "[D]ebug [B]reakpoint" },
    --   { "<leader>dr", "<cmd>GdbRun<CR>",   desc = "[D]ebug [R]un" },
    -- }
  },

  -- Plugin pour commenter/décommenter facilement
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy', -- Charger après le démarrage, quand nécessaire
    opts = {
      mappings = {
        basic = false,
        extra = false,
        extended = false,
      },
      -- Options de configuration si tu veux personnaliser (voir doc Comment.nvim)
      -- Par exemple, pour ajouter des mappings personnalisés ou ignorer certains filetypes
    },
    -- Comment.nvim configure généralement les mappings par défaut (gcc, gc, gb)
    -- Si tu veux les redéfinir, tu peux le faire ici ou dans keybinds.lua APRES le chargement
  },

  -- Plugin de Terminal FTerm
  {
    'numToStr/FTerm.nvim',
    event = 'VeryLazy',
    opts = {
      -- Configuration de base (voir doc FTerm.nvim pour plus d'options)
      border = 'double', -- 'single', 'double', 'rounded', 'solid', 'shadow'
      dimensions = {
        height = 0.9,
        width = 0.9,
        x = 0.5,
        y = 0.5,
      },
    },
    -- Ajoutons un mapping pour le basculer
    keys = {
      {
        '<leader>ft',
        function()
          require('FTerm').toggle()
        end,
        desc = 'Toggle [F]loating [T]erminal',
      },
      -- Tu peux ajouter d'autres mappings FTerm ici
    },
  },

  -- Plugin pour sélection/édition multiple
  {
    'mg979/vim-visual-multi',
    event = 'VeryLazy',
    -- Ce plugin est souvent configuré via des variables globales vim.g
    -- Exemple (à mettre AVANT le setup de lazy si tu veux configurer) :
    -- vim.g.VM_maps = {}
    -- vim.g.VM_maps['Find Under'] = '<C-d>' -- exemple pour remaper
    init = function()
      -- Définir des variables globales AVANT le chargement si nécessaire
      -- vim.g.VM_leader = '\\' -- Changer la leader key de VM si besoin
    end,
  },

  -- Plugin Noice pour refondre l'UI
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    -- IMPORTANT: Noice a des dépendances
    dependencies = {
      'MunifTanjim/nui.nvim',
      -- Recommandé:
      'rcarriga/nvim-notify',
    },
    opts = {
      cmdline = {
        enabled = true,
        view = 'cmdline_popup',
        opts = {},
        format = {
          cmdline = { pattern = '^:', icon = '', lang = 'vim' },
          search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
          search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
          filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
          lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
          help = { pattern = '^:%s*he?l?p?%s+', icon = '?' },
          input = {},
        },
      },
      messages = {
        enabled = false,
        view = 'notify',
        view_error = 'notify',
        view_warn = 'notify',
        view_history = 'messages',
        view_search = 'virtualtext',
      },
      popupmenu = {
        enabled = true,
        backend = 'nui',
        kind_icons = {},
      },
      redirect = {
        view = 'popup',
        filter = { event = 'msg_show' },
      },
      commands = {
        history = {
          view = 'split',
          opts = { enter = true, format = 'details' },
          filter = {
            any = {
              { event = 'notify' },
              { error = true },
              { warning = true },
              { event = 'msg_show', kind = { '' } },
              { event = 'lsp', kind = 'message' },
            },
          },
        },
        last = {
          view = 'popup',
          opts = { enter = true, format = 'details' },
          filter = {
            any = {
              { event = 'notify' },
              { error = true },
              { warning = true },
              { event = 'msg_show', kind = { '' } },
              { event = 'lsp', kind = 'message' },
            },
          },
          filter_opts = { count = 1 },
        },
        errors = {
          view = 'popup',
          opts = { enter = true, format = 'details' },
          filter = { error = true },
          filter_opts = { reverse = true },
        },
      },
      notify = {
        enabled = true,
        view = 'notify',
      },
      lsp = {
        progress = {
          enabled = true,
          format = 'lsp_progress',
          format_done = 'lsp_progress_done',
          throttle = 1000 / 30,
          view = 'mini',
        },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = false,
          ['vim.lsp.util.stylize_markdown'] = false,
          ['cmp.entry.get_documentation'] = false,
        },
        hover = {
          enabled = true,
          silent = false,
          view = nil,
          opts = {},
        },
        signature = {
          enabled = false,
          auto_open = {
            enabled = true,
            trigger = true,
            luasnip = true,
            throttle = 50,
          },
          view = nil,
          opts = {},
        },
        message = {
          enabled = true,
          view = 'notify',
          opts = {},
        },
        documentation = {
          view = 'hover',
          opts = {
            lang = 'markdown',
            replace = true,
            render = 'plain',
            format = { '{message}' },
            win_options = { concealcursor = 'n', conceallevel = 3 },
          },
        },
      },
      markdown = {
        highlights = {
          ['|%S-|'] = '@text.reference',
          ['@%S+'] = '@parameter',
          ['^%s*(Parameters:)'] = '@text.title',
          ['^%s*(Return:)'] = '@text.title',
          ['^%s*(See also:)'] = '@text.title',
          ['{%S-}'] = '@parameter',
        },
      },
      health = {
        checker = true,
      },
      smart_move = {
        enabled = true,
        excluded_filetypes = { 'cmp_menu', 'cmp_docs', 'notify' },
      },
      presets = {
        bottom_search = false,
        command_palette = false,
        long_message_to_split = false,
        inc_rename = false,
        lsp_doc_border = false,
      },
      throttle = 1000 / 30,
      views = {},
      routes = {},
      status = {},
      format = {},
    },
  },

  -- Plugin pour afficher les images
  '3rd/image.nvim',

  -- Plugin pour prévisualiser les fichiers dans NvimTree
  'b0o/nvim-tree-preview.lua',

  -- Collection de fonctions Lua utiles
  'nvim-lua/plenary.nvim',

  -- LazyDev (pour améliorer l'expérience de dev Lua pour la config Neovim)
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- Charge seulement pour les fichiers Lua
    opts = {
      library = {
        -- Inclut les types pour vim.uv (Neovim >= 0.10)
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        -- Inclut les types pour l'API Neovim Runtime (nécessite Neovim >= 0.10)
        { path = '${rtp}/lua' },
        { path = '${rtp}/lua/vim/lsp' },
      },
    },
  },

  -- Autres plugins utiles (décommente et configure si tu veux)
  -- { 'numToStr/Comment.nvim', opts = {} }, -- Pour commenter/décommenter facilement (gcc, gc<motion>)
  -- { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }, opts = { theme = 'auto' } }, -- Alternative à mini.statusline/airline
  -- { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} }, -- Lignes d'indentation visuelles
  -- { 'windwp/nvim-autopairs', event = "InsertEnter", opts = {} }, -- Ferme automatiquement les paires (), [], {} etc.
} -- Fin de la table retournée
