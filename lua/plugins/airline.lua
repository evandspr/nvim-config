-- Configuration de Airline

-- Configuration globale
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#formatter'] = 'unique_tail'
vim.g['airline#extensions#branch#enabled'] = 1
vim.g['airline#extensions#hunks#enabled'] = 1

-- Configuration des sections
vim.g.airline_section_a = '%{airline#util#wrap(airline#parts#mode(),0)}'
vim.g.airline_section_b = '%{airline#util#wrap(airline#extensions#branch#get_head(),0)}'
vim.g.airline_section_c = '%{airline#util#wrap(airline#parts#path(),0)}'

-- Configuration du thème
vim.g.airline_theme = 'bubblegum'

-- Utilisation de powerline fonts si disponibles
if vim.g.have_nerd_font then
  vim.g.airline_powerline_fonts = 1
else
  vim.g.airline_symbols_ascii = 1
end

-- Configuration avancée
vim.g['airline#extensions#default#layout'] = {
  { 'a', 'b', 'c' },
  { 'x', 'y', 'z', 'error', 'warning' }
} 