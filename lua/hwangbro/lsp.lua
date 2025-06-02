-- this is where you enable features that only work
-- if there is a language server active in the file

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", "[R]e[n]ame")
        map("<leader>vd", "<cmd>lua vim.diagnostic.open_float()<cr>", "[V]im [D]iagnostic")
        map("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", "[C]ode [A]ction")

        local function client_supports_method(client, method, bufnr)
            if vim.fn.has("nvim-0.11") == 1 then
                return client:supports_method(method, bufnr)
            else
                return client.supports_method(method, { bufnr = bufnr })
            end
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if
            client
            and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
        then
            local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
                end,
            })
        end
    end,
})

local function restart_lsp(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    local clients
    if vim.lsp.get_clients then
        clients = vim.lsp.get_clients({ bufnr = bufnr })
    else
        ---@diagnostic disable-next-line:deprecated
        clients = vim.lsp.get_active_clients({ bufnr = bufnr })
    end

    for _, client in ipairs(clients) do
        vim.lsp.stop_client(client.id)
    end

    vim.defer_fn(function()
        vim.cmd("edit")
    end, 100)
end

vim.api.nvim_create_user_command("LspRestart", function()
    restart_lsp()
end, {})

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
vim.lsp.enable({ "basedpyright", "lua_ls", "roslyn_ls" })
-- vim.lsp.enable({ "csharp_ls "})
