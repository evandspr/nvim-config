-- Configuration centralisée
-- Ce fichier permet de configurer les paramètres globaux et d'initialiser les modules

local M = {}

-- Chemins importants
M.paths = {
  config = vim.fn.stdpath('config'),
  data = vim.fn.stdpath('data'),
  cache = vim.fn.stdpath('cache'),
}

-- Configuration globale
M.options = {
  -- Paramètres visuels
  colorscheme = 'eldritch',
  transparent = true,
  
  -- Paramètres d'édition
  indent = 4,
  
  -- Paramètres de terminal
  shell = vim.loop.os_uname().sysname == 'Windows_NT' and 'powershell' or 'bash',
  
  -- Mappings leader
  leader = ' ',
  localleader = '\\',
  
  -- Fonctionnalités
  format_on_save = true,
  line_wrap = true,
  
  -- Personnalisation
  nerd_font = true,
}

-- Configuration des mappings généraux
M.mappings = {
  -- Navigation
  ['<C-h>'] = { '<C-w>h', mode = 'n', desc = 'Naviguer vers la fenêtre gauche' },
  ['<C-j>'] = { '<C-w>j', mode = 'n', desc = 'Naviguer vers la fenêtre du bas' },
  ['<C-k>'] = { '<C-w>k', mode = 'n', desc = 'Naviguer vers la fenêtre du haut' },
  ['<C-l>'] = { '<C-w>l', mode = 'n', desc = 'Naviguer vers la fenêtre droite' },
  
  -- Buffer/Tab
  ['<leader>tn'] = { '<cmd>tabnew<CR>', mode = 'n', desc = 'Nouvel onglet' },
  ['<leader>tc'] = { '<cmd>tabclose<CR>', mode = 'n', desc = 'Fermer onglet' },
  
  -- Échappement et nettoyage
  ['<Esc>'] = { '<cmd>nohlsearch<CR>', mode = 'n', desc = 'Effacer surbrillance recherche' },
  ['<Esc><Esc>'] = { '<C-\\><C-n>', mode = 't', desc = 'Quitter mode terminal' },
  
  -- Édition
  ['<C-s>'] = { '<cmd>w<CR>', mode = 'n', desc = 'Sauvegarder' },
  ['<leader>q'] = { '<cmd>wqa<CR>', mode = 'n', desc = 'Sauvegarder et quitter tout' },
  
  -- Interface
  ['<leader>e'] = { '<cmd>NvimTreeToggle<CR>', mode = 'n', desc = 'Explorateur de fichiers' },
  
  -- LSP
  ['gd'] = { vim.lsp.buf.definition, mode = 'n', desc = 'Aller à la définition' },
  ['K'] = { vim.lsp.buf.hover, mode = 'n', desc = 'Afficher documentation' },
  
  -- Telescope
  ['<leader>ff'] = { '<cmd>Telescope find_files<CR>', mode = 'n', desc = 'Chercher fichiers' },
  ['<leader>fg'] = { '<cmd>Telescope live_grep<CR>', mode = 'n', desc = 'Chercher dans fichiers' },
}

-- Initialisation des modules
function M.setup()
  -- Définir les options globales
  vim.g.mapleader = M.options.leader
  vim.g.maplocalleader = M.options.localleader
  vim.g.have_nerd_font = M.options.nerd_font
  
  -- Appliquer les mappings
  for key, mapping in pairs(M.mappings) do
    vim.keymap.set(mapping.mode or 'n', key, mapping[1], { desc = mapping.desc })
  end
  
  -- Charger les modules
  require('core.options')
  require('core.keymaps')
  require('core.autocommands')
  
  -- Charger les plugins après l'initialisation
  local lazy = require('lazy')
  lazy.setup('plugins', {
    performance = {
      rtp = {
        disabled_plugins = {
          'gzip', 'matchit', 'matchparen', 'netrwPlugin',
          'tarPlugin', 'tohtml', 'tutor', 'zipPlugin',
        },
      },
    },
  })
  
  -- Appliquer le colorscheme
  local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. M.options.colorscheme)
  if not status_ok then
    vim.notify('Colorscheme ' .. M.options.colorscheme .. ' non trouvé !', vim.log.levels.WARN)
  end
end

return M 