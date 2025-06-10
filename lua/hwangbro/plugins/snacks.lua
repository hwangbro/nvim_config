return {
    "folke/snacks.nvim",
    opts = {
        picker = {},
    },
    keys = {
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
    },
}
