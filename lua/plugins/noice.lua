-- Configuration de Noice
-- Interface utilisateur améliorée pour Neovim

require('noice').setup {
  -- Configuration de la ligne de commande
  cmdline = {
    enabled = true,
    view = 'cmdline_popup',
    format = {
      cmdline = { pattern = '^:', icon = '', lang = 'vim' },
      search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
      search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
      filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
      lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
      help = { pattern = '^:%s*he?l?p?%s+', icon = '?' },
    },
  },
  
  -- Configuration des messages
  messages = {
    enabled = true,
    view = 'notify',
    view_error = 'notify',
    view_warn = 'notify',
    view_history = 'messages',
    view_search = 'virtualtext',
  },
  
  -- Configuration du menu popup
  popupmenu = {
    enabled = true,
    backend = 'nui',
  },
  
  -- Configuration des redirections
  redirect = {
    view = 'popup',
    filter = { event = 'msg_show' },
  },
  
  -- Configuration des notifications
  notify = {
    enabled = true,
    view = 'notify',
  },
  
  -- Configuration LSP
  lsp = {
    -- Override pour les informations LSP hover
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true,
    },
    
    -- Barre de progression
    progress = {
      enabled = true,
      format = 'lsp_progress',
      format_done = 'lsp_progress_done',
      throttle = 1000 / 30,
      view = 'mini',
    },
    
    -- Documentation au survol
    hover = {
      enabled = true,
      silent = false,
      view = nil, -- Auto-détection du mode approprié
    },
    
    -- Aide à la signature
    signature = {
      enabled = true,
      auto_open = {
        enabled = true,
        trigger = true,
        luasnip = true,
        throttle = 50,
      },
    },
    
    -- Messages LSP
    message = {
      enabled = true,
      view = 'notify',
    },
    
    -- Documentation
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
  
  -- Configuration Markdown
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
  
  -- Configuration des préréglages
  presets = {
    bottom_search = true,          -- Utiliser un emplacement inférieur pour la recherche
    command_palette = true,         -- Position de la palette de commandes
    long_message_to_split = true,  -- Messages longs dans un split
    inc_rename = true,             -- Renommage incrémental
    lsp_doc_border = true,         -- Ajouter une bordure aux docs LSP
  },
  
  -- Configuration des routes (spéciales)
  routes = {
    -- Supprime les messages ennuyeux
    {
      filter = {
        event = "msg_show",
        kind = "",
        find = "written",
      },
      opts = { skip = true },
    },
    -- Améliore l'affichage des messages longs
    {
      filter = {
        event = "msg_show",
        min_height = 10,
      },
      view = "split",
    },
  },
  
  -- Déclenchement du déplacement intelligent
  smart_move = {
    enabled = true,
    excluded_filetypes = { 'cmp_menu', 'cmp_docs', 'notify' },
  },
} 