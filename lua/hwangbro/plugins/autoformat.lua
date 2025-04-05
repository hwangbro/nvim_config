return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({ async = true })
            end,
            mode = "",
            desc = "Format buffer",
        },
    },

    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        notify_on_error = false,
        format_on_save = {
            timeout_ms = 2500,
            lsp_format = "fallback",
        },
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "black" },
            c_sharp = { "csharpier" },
            cs = { "csharpier" },
        },
        formatters = {
            stylua = {
                prepend_args = { "--indent-type", "Spaces" },
            },
            csharpier = {
                command = "dotnet-csharpier",
                args = { "--write-stdout" },
            },
        },
    },
}
