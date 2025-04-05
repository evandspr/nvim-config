--[[
=====================================================================
==================== CONFIGURATION NEOVIM OPTIMISÉE =================
=====================================================================
  Fichier d'initialisation principal pour une configuration Neovim
  modulaire, performante et fonctionnelle.
=====================================================================
--]]

-- Leader key (défini tôt pour éviter les problèmes de mappings)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Paramètre pour les Nerd Fonts
vim.g.have_nerd_font = true

-- Désactiver netrw avant tout chargement
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Installer lazy.nvim s'il n'est pas présent
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none', '--branch=stable',
    'https://github.com/folke/lazy.nvim.git', lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Charger et initialiser la configuration centralisée
require('config').setup()

-- Chargement des modules de base
require('core.options')    -- Options générales
require('core.keymaps')    -- Mappings globaux
require('core.autocommands') -- Autocommandes

-- Chargement des plugins via lazy.nvim
require('lazy').setup('plugins', {
  ui = {
    -- Icônes pour l'interface de lazy.nvim
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤',
    },
  },
  change_detection = {
    notify = false,  -- Désactive les notifications de changement de fichier
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})

-- Chargement du colorscheme après l'initialisation des plugins
require('colors')

-- Autocommand pour surligner le texte copié
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Surligne le texte copié',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 300 })
  end,
})

-- vim: ts=2 sts=2 sw=2 et
