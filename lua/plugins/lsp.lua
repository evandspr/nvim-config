-- Configuration de LSP

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Configuration globale
local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
  vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
end

-- Configuration des serveurs LSP
local servers = {
  'clangd',
  'pyright',
  'rust_analyzer',
  'tsserver',
  'html',
  'cssls',
  'lua_ls',
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Configuration spécifique pour clangd
lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    'clangd',
    '--background-index',
    '--suggest-missing-includes',
    '--clang-tidy',
    '--header-insertion=iwyu',
  },
}

-- Configuration spécifique pour lua_ls
lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

-- Configuration de Mason
require('mason').setup {
  ui = {
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗',
    },
  },
}

-- Configuration de Mason LSP Config
require('mason-lspconfig').setup {
  ensure_installed = vim.tbl_keys(servers),
  automatic_installation = true,
}

-- Configuration des outils Mason
require('mason-tool-installer').setup {
  ensure_installed = {
    'stylua',
    'clang-format',
    'cmake-language-server',
  },
  auto_update = true,
  run_on_start = true,
}

-- Configuration de Fidget
require('fidget').setup {
  text = {
    spinner = 'dots',
  },
  window = {
    relative = 'win',
    blend = 0,
  },
}

-- Configuration des diagnostics
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {
    text = {
      [vim.diagnostic.severity.ERROR] = 'E>',
      [vim.diagnostic.severity.WARN] = 'W>',
      [vim.diagnostic.severity.INFO] = 'I>',
      [vim.diagnostic.severity.HINT] = 'H>',
    },
  },
  virtual_text = { source = 'if_many', spacing = 2 },
} 