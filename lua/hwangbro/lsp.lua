-- this is where you enable features that only work
-- if there is a language server active in the file

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- map("gd", "<cmd>lua vim.lsp.buf.definition()<cr>", "[G]oto [D]efinition")
        -- map("gr", "<cmd>lua vim.lsp.buf.references()<cr>", "[G]oto [R]eference")
        map("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", "[R]e[n]ame")
    end,
})

-- copied straight from blink
local capabilities = {
    textDocument = {
        foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        },
    },
}

capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

-- setup language servers
vim.lsp.config("*", {
    capabilities = capabilities,
    root_markers = { ".git" },
})

-- enable lsps
vim.lsp.enable({ "basedpyright", "lua_ls" })
-- vim.lsp.enable({ "csharp_ls "})
