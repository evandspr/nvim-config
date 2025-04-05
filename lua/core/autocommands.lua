-- Configuration des autocommandes

local function create_augroup(name, clear)
  return vim.api.nvim_create_augroup(name, { clear = clear })
end

-- Groupe pour la configuration de base
local base_group = create_augroup('base_config', true)

-- Sauvegarder le curseur et le fold
vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
  group = base_group,
  pattern = '*',
  callback = function()
    vim.cmd([[
      if line("'\"") > 1 && line("'\"") <= line("$")
        exe "normal! g`\""
      endif
    ]])
  end,
})

-- Désactiver la continuation des commentaires
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = base_group,
  pattern = '*',
  callback = function()
    vim.opt.formatoptions:remove('c')
    vim.opt.formatoptions:remove('r')
    vim.opt.formatoptions:remove('o')
  end,
})

-- Groupe pour les fichiers spécifiques
local filetype_group = create_augroup('filetype_config', true)

-- Configuration pour les fichiers Makefile
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = filetype_group,
  pattern = 'make',
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 8
    vim.opt_local.shiftwidth = 8
    vim.opt_local.softtabstop = 8
  end,
})

-- Configuration pour les fichiers C
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = filetype_group,
  pattern = { 'c', 'cpp' },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

-- Groupe pour les événements LSP
local lsp_group = create_augroup('lsp_config', true)

-- Configuration pour le surlignage des références
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
  group = lsp_group,
  callback = function()
    vim.lsp.buf.document_highlight()
  end,
})

vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
  group = lsp_group,
  callback = function()
    vim.lsp.buf.clear_references()
  end,
})

-- Groupe pour les événements de sauvegarde
local save_group = create_augroup('save_config', true)

-- Formatage automatique à la sauvegarde
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = save_group,
  pattern = '*',
  callback = function()
    local filetype = vim.bo.filetype
    if filetype ~= 'c' and filetype ~= 'cpp' then
      vim.lsp.buf.format()
    end
  end,
}) 