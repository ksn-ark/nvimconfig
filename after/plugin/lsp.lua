local util = require 'lspconfig.util'
local lsp_zero = require("lsp-zero").preset({
    set_basic_mappings = false,
    set_extra_mappings = false,
})
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'tsserver',
        'eslint',
        'pylsp',
        'lua_ls',
        'rust_analyzer',
        'cssls',
        'terraformls'
    },
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
        end,
        eslint = function()
            local eslint_opts = { workingDirectories = { mode = "auto" } }
            require("lspconfig").eslint.setup(eslint_opts)
        end,
        cssls = function()
            local cssls_opts = {
                cmd = { "vscode-css-language-server", "--stdio" },
                filetypes = { "css", "scss", "less" },
                init_options = { provideFormatter = true },
                root_dir = util.root_pattern('package.json', '.git'),
                single_file_support = true,
                settings = {
                    css = { validate = true },
                    scss = { validate = true },
                    less = { validate = true },
                },
            }
            require('lspconfig').cssls.setup(cssls_opts)
        end,
        terraformls = function()
            local terraformls_opts = {
                cmd = { "terraform-ls", "serve" },
                filetypes = { "terraform", "hcl" },
                root_dir = util.root_pattern(".terraform", ".git"),
            }
            require('lspconfig').terraformls.setup(terraformls_opts)
        end,
    }
})
local cmp = require("cmp")
cmp.setup({
    formatting = lsp_zero.cmp_format(),
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }
})

local picker = require("telescope.builtin")

lsp_zero.on_attach(function(client, bufnum)
    local opts = { buffer = bufnum, remap = false }
    -- Info popup
    vim.keymap.set("n", "<leader>i", vim.lsp.buf.hover, opts) -- Inspect

    -- Jump
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", function() picker.lsp_references({ include_declaration = false, }) end, opts)
    vim.keymap.set("n", "<leader>fs", picker.lsp_document_symbols, opts) -- find symbols

    -- Diagnostics
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>fd", picker.diagnostics, opts) -- Find diagnostics
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

    -- Actions
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)

    -- Toggle inlay hints
    vim.keymap.set("n", "<leader>v", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
    end)

    -- Automatic format on save
    vim.cmd [[autocmd BufWritePre * silent! lua vim.lsp.buf.format({filter = function(c) return c.name ~="tsserver" end})]]
end)

lsp_zero.setup()
