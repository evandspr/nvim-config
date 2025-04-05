-- Fichier: lua/colors.lua
-- Active le colorscheme après le chargement des plugins

-- Vérifie si la fonction 'colorscheme' existe (sécurité)
local status_ok, _ = pcall(vim.cmd, 'colorscheme eldritch')
if not status_ok then
  vim.notify('Colorscheme eldritch non trouvé !', vim.log.levels.WARN)
  -- Tu peux mettre un fallback ici si tu veux
  -- pcall(vim.cmd, 'colorscheme default')
  return
end

-- Optionnel: Tu pourrais ajouter ici des configurations qui dépendent
-- du colorscheme chargé, par exemple ajuster certains highlights.
-- Exemple:
-- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#3B4252' }) -- Ajuste le fond des fenêtres flottantes
