return {
    "folke/snacks.nvim",
    lazy = false,
    ---@type snacks.Config
    opts = {
        picker = {},
        explorer = { enabled = true },
    },
    keys = {
        {
            "<leader>e",
            function()
                Snacks.explorer()
            end,
            desc = "File Explorer",
        },
        {
            "<leader>sf",
            function()
                Snacks.picker.files()
            end,
            desc = "[S]earch [F]iles",
        },
        {
            "<leader>sg",
            function()
                Snacks.picker.grep()
            end,
            desc = "[S]earch [G]rep",
        },
        -- lsp
        {
            "gd",
            function()
                Snacks.picker.lsp_definitions()
            end,
            desc = "[G]oto [D]efinition",
        },
        {
            "gr",
            function()
                Snacks.picker.lsp_references()
            end,
            nowait = true,
            desc = "[G]oto [R]eferences",
        },
        {
            "gI",
            function()
                Snacks.picker.lsp_implementations()
            end,
            desc = "[G]oto [I]mplementations",
        },
    },
}
