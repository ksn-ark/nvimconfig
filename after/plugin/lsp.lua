local lsp_zero = require("lsp-zero").preset({
    set_basic_mappings = false,
    set_extra_mappings = false,
})

-- mason-lspconfig v2 enables installed servers via vim.lsp.enable,
-- so per-server options live in vim.lsp.config (merged over nvim-lspconfig's defaults)
vim.lsp.config('*', { capabilities = require('cmp_nvim_lsp').default_capabilities() })
vim.lsp.config('lua_ls', lsp_zero.nvim_lua_ls())
vim.lsp.config('terraformls', { filetypes = { "terraform", "hcl" } })

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'ts_ls',
        'eslint',
        'pylsp',
        'lua_ls',
        'rust_analyzer',
        'cssls',
        'terraformls'
    },
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
    vim.cmd [[autocmd BufWritePre * silent! lua vim.lsp.buf.format({filter = function(c) return c.name ~="ts_ls" end})]]
end)

lsp_zero.setup()
