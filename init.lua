--[[
=====================================================================
====================       KICKSTART.NVIM       =====================
=====================================================================
  Ton fichier de configuration principal. Garde les options
  globales et charge les autres modules (plugins, keybinds, colors).
=====================================================================
--]]

-- Leader key (doit être défini tôt)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Flag pour Nerd Font (utilisé par certains plugins)
vim.g.have_nerd_font = true -- Met à true si tu utilises une Nerd Font

-- Options globales de Neovim (gardées ici pour la clarté)
-- Voir `:help vim.opt`
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus' -- Attention: peut ralentir le démarrage
end)
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.confirm = true
vim.opt.termguicolors = true -- Important pour les thèmes modernes

-- Désactiver netrw (NvimTree le remplacera)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Autocommand pour surligner le yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Installation et setup de lazy.nvim (Gestionnaire de plugins)
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath) -- @diagnostic disable-line: undefined-field

-- Chargement des modules personnalisés
require('keybinds') -- Charge les raccourcis depuis lua/keybinds.lua

-- Configuration et chargement des plugins via lazy.nvim
-- La liste des plugins est maintenant dans lua/plugins/init.lua
require('lazy').setup(require('plugins'), {
  ui = {
    -- Icônes pour l'interface de lazy.nvim (optionnel)
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘', config = '🛠', event = '📅', ft = '📂', init = '⚙',
      keys = '🗝', plugin = '🔌', runtime = '💻', require = '🌙',
      source = '📄', start = '🚀', task = '📌', lazy = '💤 ',
    },
  },
})

-- Chargement du colorscheme (après que lazy ait potentiellement chargé le plugin)
require('colors')

-- Mode line (laisse la à la fin)
-- vim: ts=2 sts=2 sw=2 et
