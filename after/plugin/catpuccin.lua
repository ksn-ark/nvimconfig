require("catppuccin").setup({
    flavour = "mocha",             -- latte, frappe, macchiato, mocha
    transparent_background = true, -- disables setting the background color.
    default_integrations = true,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        telescope = {
            enabled = true,
            -- style = "nvchad"
        }
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
