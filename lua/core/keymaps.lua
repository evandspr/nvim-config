-- Configuration des raccourcis clavier

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Raccourcis de base
map('n', '<Esc>', '<cmd>nohlsearch<CR>')  -- Désactiver la recherche en surbrillance
map('n', '<C-h>', '<C-w>h')               -- Navigation entre fenêtres
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Raccourcis pour les onglets
map('n', '<leader>tn', '<cmd>tabnew<CR>', { desc = '[T]ab [N]ew' })
map('n', '<leader>tc', '<cmd>tabclose<CR>', { desc = '[T]ab [C]lose' })
map('n', '<leader>to', '<cmd>tabonly<CR>', { desc = '[T]ab [O]nly' })
map('n', '<leader>tm', '<cmd>tabmove<CR>', { desc = '[T]ab [M]ove' })

-- Raccourcis pour la recherche
map('n', 'n', 'nzzzv')                    -- Garder la recherche centrée
map('n', 'N', 'Nzzzv')
map('n', '*', '*zzzv')
map('n', '#', '#zzzv')
map('n', 'g*', 'g*zzzv')
map('n', 'g#', 'g#zzzv')

-- Raccourcis pour le copier/coller
map('v', '<leader>y', '"+y', { desc = '[Y]ank to clipboard' })
map('n', '<leader>y', '"+y')
map('v', '<leader>d', '"+d', { desc = '[D]elete to clipboard' })
map('n', '<leader>d', '"+d')
map('v', '<leader>p', '"+p', { desc = '[P]aste from clipboard' })
map('n', '<leader>p', '"+p')

-- Raccourcis pour la navigation dans les fichiers
map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Explorer' })
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = '[F]ind [F]iles' })
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { desc = '[F]ind by [G]rep' })
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { desc = '[F]ind [B]uffers' })
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { desc = '[F]ind [H]elp' })

-- Raccourcis pour le formatage
map('n', '<leader>f', '<cmd>Format<CR>', { desc = '[F]ormat' })
map('n', '<leader>F', '<cmd>FormatWrite<CR>', { desc = '[F]ormat and write' })

-- Raccourcis pour les commandes 42
map('n', '<F1>', '<cmd>Stdheader<CR>', { desc = '42 Header' })
map('n', '<leader>nh', '<cmd>Header42<CR>', { desc = '[N]orminette [H]eader' })
map('n', '<leader>nn', '<cmd>Norminette<CR>', { desc = '[N]orminette' })

-- Raccourcis pour le débogage
map('n', '<leader>db', '<cmd>GdbBreak<CR>', { desc = '[D]ebug [B]reakpoint' })
map('n', '<leader>dr', '<cmd>GdbRun<CR>', { desc = '[D]ebug [R]un' })
map('n', '<leader>dn', '<cmd>GdbNext<CR>', { desc = '[D]ebug [N]ext' })
map('n', '<leader>ds', '<cmd>GdbStep<CR>', { desc = '[D]ebug [S]tep' })
map('n', '<leader>dc', '<cmd>GdbContinue<CR>', { desc = '[D]ebug [C]ontinue' })

-- Raccourcis pour le terminal
map('n', '<leader>ft', '<cmd>FTermToggle<CR>', { desc = '[F]loating [T]erminal' })
map('t', '<Esc>', '<C-\\><C-n>')         -- Sortir du mode terminal avec Esc 