return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- Color scheme
    use "projekt0n/github-nvim-theme"

    use {
        "neovim/nvim-lspconfig",
        "williamboman/nvim-lsp-installer",
    }

    use "glepnir/lspsaga.nvim"

    use "nvim-treesitter/nvim-treesitter"

    use "windwp/nvim-autopairs"

    use {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "quangnguyen30192/cmp-nvim-ultisnips",
    }

    use {
        "nvim-telescope/telescope.nvim",
        requires = "nvim-lua/plenary.nvim",
    }

    use {
        "kyazdani42/nvim-web-devicons"
    }

    use {
        "hood/popui.nvim",
        requires = "RishabhRD/popfix",
    }

    use {
        "ray-x/lsp_signature.nvim"
    }

    use {
        "jose-elias-alvarez/null-ls.nvim",
        requires = "nvim-lua/plenary.nvim",
    }

    use {
        "blackCauldron7/surround.nvim",
    }

    use "winston0410/commented.nvim"

    use "lukas-reineke/indent-blankline.nvim"

    use "editorconfig/editorconfig-vim"

    use "christoomey/vim-tmux-navigator"

    use "dstein64/nvim-scrollview"

    use "windwp/nvim-ts-autotag"

    use "romgrk/nvim-treesitter-context"

    use "nacro90/numb.nvim"

    use {
        "kyazdani42/nvim-tree.lua",
        requires = "kyazdani42/nvim-web-devicons",
    }

    use {
        "romgrk/barbar.nvim",
        requires = "kyazdani42/nvim-web-devicons",
    }

    use {
        "lewis6991/gitsigns.nvim",
        requires = "nvim-lua/plenary.nvim",
    }

    use {
        "TimUntersberger/neogit",
        requires = "nvim-lua/plenary.nvim",
    }

    use {
        "sindrets/diffview.nvim",
        requires = "nvim-lua/plenary.nvim",
    }

    use {
        "windwp/nvim-spectre",
        requires = "nvim-lua/plenary.nvim",
    }


    use {
        "nvim-telescope/telescope-frecency.nvim",
        requires = "tami5/sqlite.lua",
    }

    use "lewis6991/spellsitter.nvim"


    use {
        "nvim-lualine/lualine.nvim",
        requires = {"kyazdani42/nvim-web-devicons", opt = true},
    }


end)

