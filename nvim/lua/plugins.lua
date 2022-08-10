return require('packer').startup(function()
    -- Packer
    use 'wbthomason/packer.nvim'

    -- Matchup
    -- use 'andymass/vim-matchup'

    -- Tree
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

    -- Git integration
    use {
        'lewis6991/gitsigns.nvim',
        config = function() require('gitsigns').setup() end
    }

    -- Color scheme
    use 'EdenEast/nightfox.nvim'

    -- Tab bar
    use {
        'romgrk/barbar.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' }
    }

    -- Status bar
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' }
    }

    -- Discord Rich Presence
    use 'andweeb/presence.nvim'
end)

