-- Configuration de WhichKey

local wk = require('which-key')

wk.setup {
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
    presets = {
      operators = true,
      motions = true,
      text_objects = true,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
  },
  operators = { gc = 'Comments' },
  key_labels = {
    ['<space>'] = 'SPC',
    ['<cr>'] = 'RET',
    ['<tab>'] = 'TAB',
  },
  icons = {
    breadcrumb = '»',
    separator = '➜',
    group = '+',
  },
  window = {
    border = 'none',
    position = 'bottom',
    margin = { 1, 0, 1, 0 },
    padding = { 2, 2, 2, 2 },
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 },
    width = { min = 20, max = 50 },
    spacing = 3,
    align = 'left',
  },
  ignore_missing = false,
  hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' },
  show_help = true,
  triggers = 'auto',
  triggers_blacklist = {
    i = { 'j', 'k' },
    v = { 'j', 'k' },
  },
}

-- Définir les raccourcis
wk.register({
  ['<leader>'] = {
    f = {
      name = 'File',
      f = { '<cmd>Telescope find_files<cr>', 'Find File' },
      g = { '<cmd>Telescope live_grep<cr>', 'Live Grep' },
      b = { '<cmd>Telescope buffers<cr>', 'Buffers' },
      h = { '<cmd>Telescope help_tags<cr>', 'Help Tags' },
    },
    g = {
      name = 'Git',
      s = { '<cmd>Gitsigns stage_hunk<cr>', 'Stage Hunk' },
      u = { '<cmd>Gitsigns undo_stage_hunk<cr>', 'Undo Stage Hunk' },
      r = { '<cmd>Gitsigns reset_hunk<cr>', 'Reset Hunk' },
      p = { '<cmd>Gitsigns preview_hunk<cr>', 'Preview Hunk' },
      b = { '<cmd>Gitsigns blame_line<cr>', 'Blame Line' },
    },
    l = {
      name = 'LSP',
      d = { '<cmd>lua vim.lsp.buf.definition()<cr>', 'Definition' },
      D = { '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Declaration' },
      i = { '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Implementation' },
      r = { '<cmd>lua vim.lsp.buf.references()<cr>', 'References' },
      k = { '<cmd>lua vim.lsp.buf.hover()<cr>', 'Hover' },
      s = { '<cmd>lua vim.lsp.buf.signature_help()<cr>', 'Signature Help' },
      a = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code Action' },
      n = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename' },
    },
    t = {
      name = 'Telescope',
      f = { '<cmd>Telescope find_files<cr>', 'Find File' },
      g = { '<cmd>Telescope live_grep<cr>', 'Live Grep' },
      b = { '<cmd>Telescope buffers<cr>', 'Buffers' },
      h = { '<cmd>Telescope help_tags<cr>', 'Help Tags' },
    },
  },
}) 