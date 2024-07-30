vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.7',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use {
        "stevearc/oil.nvim",
        config = function() require("oil").setup() end,
    }

    use {
        "cbochs/grapple.nvim",
        requires = { "nvim-tree/nvim-web-devicons" }
    }

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'mbbill/undotree'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat' -- This is just for vim-surround
    use 'tpope/vim-fugitive'
    use 'lewis6991/gitsigns.nvim'
    use 'mhinz/vim-startify'
    use 'norcalli/nvim-colorizer.lua'
    use 'sbdchd/neoformat'
    use 'christoomey/vim-tmux-navigator'

    use {
        'nvim-lualine/lualine.nvim',
        requires = { { 'nvim-tree/nvim-web-devicons', opt = true } }
    }

    -- Highlights TODO/FIXME/etc
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function() require("todo-comments").setup {} end
    }

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment these if you want to manage LSP servers from neovim
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    }
    use {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup {
                -- Manual mode doesn't automatically change your root directory, so you have
                -- the option to manually do so using `:ProjectRoot` command.
                manual_mode = false,

                -- Methods of detecting the root directory. **"lsp"** uses the native neovim
                -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
                -- order matters: if one is not detected, the other is used as fallback. You
                -- can also delete or rearangne the detection methods.
                detection_methods = { "lsp", "pattern" },

                -- All the patterns used to detect root dir, when **"pattern"** is in
                -- detection_methods
                patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

                -- Table of lsp clients to ignore by name
                -- eg: { "efm", ... }
                ignore_lsp = {},

                -- Don't calculate root dir on specific directories
                -- Ex: { "~/.cargo/*", ... }
                exclude_dirs = {},

                -- Show hidden files in telescope
                show_hidden = false,

                -- When set to false, you will get a message when project.nvim changes your
                -- directory.
                silent_chdir = true,

                -- What scope to change the directory, valid options are
                -- * global (default)
                -- * tab
                -- * win
                scope_chdir = 'global',

                -- Path where project.nvim will store the project history for use in
                -- telescope
                datapath = vim.fn.stdpath("data"),
            }
        end
    }
    use { "diegoulloao/neofusion.nvim" }
end)
