-- Configuration des options de base de Neovim
-- Fichier: lua/core/options.lua

local opt = vim.opt
local g = vim.g

--------------------------------------------------
-- Apparence et interface
--------------------------------------------------
opt.termguicolors = true          -- Activer les vraies couleurs
opt.number = true                  -- Afficher les numéros de ligne
opt.relativenumber = true          -- Numéros de ligne relatifs
opt.cursorline = true              -- Surbrillance de la ligne courante
opt.signcolumn = 'yes'             -- Toujours afficher la colonne des signes
opt.showmode = false               -- Ne pas afficher le mode (pour statusline)
opt.cmdheight = 1                  -- Hauteur de la ligne de commande
opt.pumheight = 10                 -- Hauteur du menu popup
opt.laststatus = 3                 -- Barre d'état globale
opt.showtabline = 2                -- Toujours afficher la barre d'onglets
opt.title = true                   -- Afficher le titre dans la barre de fenêtre

-- Visibilité des caractères spéciaux
opt.list = true                    -- Afficher les caractères invisibles
opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣',
  extends = '▶',
  precedes = '◀',
}

-- Défilement et marges
opt.scrolloff = 8                  -- Garder 8 lignes autour du curseur
opt.sidescrolloff = 8              -- Garder 8 colonnes autour du curseur
opt.wrap = false                   -- Ne pas couper les lignes longues

--------------------------------------------------
-- Comportement et édition
--------------------------------------------------
opt.mouse = 'a'                    -- Activer la souris dans tous les modes
opt.clipboard = 'unnamedplus'      -- Utiliser le presse-papiers système
opt.autowrite = true               -- Enregistrer auto avant certaines commandes
opt.confirm = true                 -- Demander confirmation avant de quitter
opt.undofile = true                -- Sauvegarder l'historique d'annulation
opt.updatetime = 250               -- Délai avant écriture du fichier swap
opt.timeoutlen = 300               -- Délai pour les combinaisons de touches
opt.completeopt = 'menu,menuone,noselect' -- Options de complétion
opt.conceallevel = 0               -- Afficher le texte normal en Markdown
opt.formatoptions = 'jcroqlnt'     -- Options de formatage de texte

-- Recherche
opt.ignorecase = true              -- Ignorer la casse dans les recherches
opt.smartcase = true               -- Sauf si majuscules dans la recherche
opt.hlsearch = true                -- Surbrillance des résultats
opt.incsearch = true               -- Recherche incrémentale

-- Indentation et tabulations
opt.expandtab = true               -- Espaces au lieu de tabulations
opt.shiftwidth = 4                 -- Largeur d'indentation
opt.tabstop = 4                    -- Largeur d'une tabulation
opt.softtabstop = 4                -- Largeur des tabulations en mode insertion
opt.smartindent = true             -- Indentation intelligente
opt.breakindent = true             -- Indenter les lignes coupées

-- Division des fenêtres
opt.splitbelow = true              -- Diviser en bas
opt.splitright = true              -- Diviser à droite
opt.equalalways = false            -- Ne pas redimensionner auto les fenêtres

-- Fichiers temporaires
opt.swapfile = false               -- Désactiver les fichiers swap
opt.backup = false                 -- Désactiver les fichiers de sauvegarde
opt.writebackup = false            -- Désactiver les fichiers de backup temporaires
opt.undodir = vim.fn.stdpath('cache') .. '/undodir' -- Dossier pour undo
opt.history = 1000                 -- Historique des commandes

--------------------------------------------------
-- Optimisations pour grands fichiers
--------------------------------------------------
-- Désactiver certaines fonctionnalités pour les grands fichiers
vim.api.nvim_create_autocmd('BufReadPre', {
  pattern = '*',
  callback = function()
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
    if ok and stats and stats.size > 1024 * 1024 then -- Fichiers > 1MB
      vim.opt_local.spell = false
      vim.opt_local.undofile = false
      vim.opt_local.swapfile = false
      vim.opt_local.foldmethod = 'manual'
      vim.cmd [[ syntax clear ]]
    end
  end,
})

--------------------------------------------------
-- Type de fichier spécifique
--------------------------------------------------
-- Makefile: utiliser des tabs
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'make',
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 8
    vim.opt_local.shiftwidth = 8
  end,
})

-- C/C++: configuration 42
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp', 'h' },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.cinoptions = 'l1'  -- Aligner les cases sur les switchs
  end,
})

-- Variables globales
g.mapleader = ' '                         -- Touche leader
g.maplocalleader = '\\'                   -- Touche leader locale
g.have_nerd_font = true                   -- Indiquer si les Nerd Fonts sont disponibles 