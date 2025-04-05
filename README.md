# Configuration Neovim Optimisée

Une configuration Neovim moderne, modulaire et performante, optimisée pour le développement C/C++ et les projets 42.

## Caractéristiques

- **Architecture modulaire** : Configuration organisée et extensible
- **Performance** : Chargement paresseux (lazy-loading) des plugins pour un démarrage rapide
- **Complétion intelligente** : Autocomplétion contextuelle avec nvim-cmp
- **Support LSP** : Configuration optimisée des serveurs de langage
- **Explorateur de fichiers** : Navigation intuitive avec NvimTree
- **Recherche avancée** : Recherche puissante avec Telescope
- **Syntaxe améliorée** : Coloration syntaxique précise avec Treesitter
- **Support Git** : Intégration Git avec Gitsigns
- **Interface moderne** : Design épuré et fonctionnel
- **Support 42** : Outils spécifiques pour la Norminette et les projets de l'école 42

## Structure

```
nvim-config/
├── init.lua                  # Point d'entrée principal
├── lua/
│   ├── config.lua            # Configuration centralisée
│   ├── colors.lua            # Configuration des couleurs
│   ├── plugins.lua           # Définition des plugins
│   ├── core/                 # Fonctionnalités de base
│   │   ├── options.lua       # Options globales
│   │   ├── keymaps.lua       # Mappings de touches
│   │   └── autocommands.lua  # Commandes automatiques
│   └── plugins/              # Configuration des plugins
│       ├── airline.lua       # Config barre de statut
│       ├── cmp.lua           # Config autocomplétion
│       ├── gitsigns.lua      # Config intégration Git
│       ├── lsp.lua           # Config LSP
│       ├── noice.lua         # Config UI améliorée
│       ├── nvimtree.lua      # Config explorateur
│       ├── telescope.lua     # Config recherche
│       ├── treesitter.lua    # Config syntaxe
│       └── whichkey.lua      # Config aide aux touches
└── snippets/                 # Fragments de code
    └── c.lua                 # Snippets pour C
```

## Installation

1. Clonez ce dépôt :
   ```bash
   git clone https://github.com/username/nvim-config.git ~/.config/nvim
   ```

2. Lancez Neovim :
   ```bash
   nvim
   ```

3. Laissez lazy.nvim installer automatiquement les plugins.

## Dépendances

- Neovim ≥ 0.9.0
- Git
- Compilateur C (pour certains plugins)
- (Optionnel) [Nerd Font](https://www.nerdfonts.com/) pour les icônes
- Serveurs LSP (installés automatiquement avec Mason)

## Raccourcis clavier principaux

| Touche          | Mode | Description                  |
|-----------------|------|------------------------------|
| `<Space>`       | N    | Leader                       |
| `<Space>e`      | N    | Explorateur de fichiers      |
| `<Space>ff`     | N    | Rechercher fichiers          |
| `<Space>fg`     | N    | Rechercher dans le contenu   |
| `<Space>fb`     | N    | Rechercher dans les buffers  |
| `gd`            | N    | Aller à la définition        |
| `K`             | N    | Afficher la documentation    |
| `<Space>ca`     | N    | Action de code               |
| `<Space>f`      | N    | Formater le code             |
| `<F1>`          | N    | Insérer en-tête 42           |
| `<Space>nh`     | N    | Norminette sur en-tête       |
| `<Space>nn`     | N    | Exécuter Norminette          |
| `<Ctrl>s`       | N    | Sauvegarder                  |
| `<Space>q`      | N    | Sauvegarder et quitter       |

## Personnalisation

La configuration est facilement personnalisable via le fichier `lua/config.lua` qui centralise les options principales.

Pour ajouter un plugin, modifiez le fichier `lua/plugins.lua` en suivant le format de lazy.nvim.

## Support

Pour signaler un problème ou suggérer une amélioration, veuillez ouvrir une issue sur GitHub.

## Licence

MIT
