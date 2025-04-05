-- Fichier: lua/keybinds.lua
-- Contient les raccourcis clavier généraux

local map = vim.keymap.set

-- Remappe <leader>q pour la liste de diagnostics Quickfix
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Raccourci pour quitter le mode terminal
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Navigation entre les fenêtres (splits) avec Ctrl + Flèches (remplace C-h/l)
map('n', '<C-Left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-Right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- Note : C-j et C-k restent inchangés pour bas/haut
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Effacer le surlignage de recherche avec <Esc>
map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

-- Raccourci pour NvimTree
map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = '[E]xplorer Toggle (NvimTree)' })

-- Raccourci pour Telescope Buffers (remplace celui que tu avais défini globalement)
-- Note: Telescope doit être chargé pour que cela fonctionne. Lazy.nvim s'en charge.
map('n', '<S-h>', function()
  require('telescope.builtin').buffers { sort_mru = true, sort_lastused = true, initial_mode = 'normal', theme = 'ivy' }
end, { desc = '[S-h] Telescope Buffers' })

-- Raccourcis pour aller à un onglet spécifique avec Shift + Numéro
map('n', '<leader><Left>', '<cmd>tabprevious<CR>', { desc = 'Previous Tab', silent = true })
map('n', '<leader><Right>', '<cmd>tabnext<CR>', { desc = 'Next Tab', silent = true })

-- Raccourci pour ouvrir un terminal dans un split vertical (à droite)
map('n', '<leader>t', '<cmd>vert terminal<CR>', { desc = '[T]oggle/Open Vertical Terminal' })
