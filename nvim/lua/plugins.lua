return require('packer').startup(function()
  -- Packer
  use 'wbthomason/packer.nvim'

  -- test
  -- use 'oxtna/vshow.lua'

  -- LSP configs
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'neovim/nvim-lspconfig'

  -- Directory tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function() require('nvim-tree').setup({
      view = {
        adaptive_size = true
      },
      renderer = {
        add_trailing = true,
        highlight_opened_files = 'icon',
        icons = {
          padding = '  ',
          symlink_arrow = ' -> ',
        },
        special_files = {
          'README.md',
          'readme.md',
        },
      },
    }) end
  }

  -- Syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = { 'nvim-lua/plenary.nvim' },
    run = ':TSUpdate'
  }

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  -- Telescope sorter
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = '\z
      cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && \z
      cmake --build build --config Release && \z
      cmake --install build --prefix build\z
    '
  }

  -- Git integration
  use {
    'lewis6991/gitsigns.nvim',
    config = function() require('gitsigns').setup() end
  }

  -- Color scheme
  use 'EdenEast/nightfox.nvim'

  -- Buffer bar
  use {
    'romgrk/barbar.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  -- Status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  -- Discord Rich Presence
  use 'andweeb/presence.nvim'
end)

