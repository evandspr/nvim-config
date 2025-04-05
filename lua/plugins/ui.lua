-- Configuration de l'interface utilisateur

-- Configuration de Noice
require('noice').setup {
  cmdline = {
    enabled = true,
    view = 'cmdline_popup',
    format = {
      cmdline = { pattern = '^:', icon = '', lang = 'vim' },
      search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
      search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
      filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
      lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
      help = { pattern = '^:%s*he?l?p?%s+', icon = '?' },
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
    hover = {
      enabled = true,
      silent = false,
    },
    signature = {
      enabled = false,
    },
    message = {
      enabled = true,
      view = 'notify',
    },
  },
  presets = {
    bottom_search = false,
    command_palette = false,
    long_message_to_split = false,
    inc_rename = false,
    lsp_doc_border = false,
  },
}

-- Configuration de la barre de statut
require('mini.statusline').setup {
  use_icons = vim.g.have_nerd_font,
  set_vim_settings = false,
  content = {
    active = function()
      return {
        { section = 'mode', trunc_width = 75 },
        { section = 'git' },
        { section = 'diagnostics' },
        { section = 'filename' },
        { section = 'searchcount' },
        { section = 'location' },
        { section = 'filetype' },
      }
    end,
  },
}

-- Configuration des couleurs
vim.cmd.colorscheme('eldritch')

-- Configuration des icônes
require('nvim-web-devicons').setup {
  override = {
    makefile = {
      icon = '',
      color = '#ffd700',
      name = 'Makefile',
    },
    c = {
      icon = '',
      color = '#519aba',
      name = 'c',
    },
    h = {
      icon = '',
      color = '#519aba',
      name = 'h',
    },
  },
} 