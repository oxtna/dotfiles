local use = require('packer').use
local return_value = require('packer').startup(function()
    -- Packer
    use 'wbthomason/packer.nvim'

    -- Matchup
    use 'andymass/vim-matchup'

    -- Tree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons'},
        config = function() require('nvim-tree').setup({}) end
    }

    -- Git
    use {
        'lewis6991/gitsigns.nvim',
        config = function() require('gitsigns').setup() end
    }

    -- Comments
    use 'tpope/vim-commentary'

    -- Color scheme
    use 'EdenEast/nightfox.nvim'

    -- Status bar
    use {
        'nvim-lualine/lualine.nvim',
        requires = {
            'kyazdani42/nvim-web-devicons',
            opt = true
        }
    }

    -- Discord Rich Presence
    use 'andweeb/presence.nvim'
end)

return return_value
