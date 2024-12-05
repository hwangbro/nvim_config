return {
    "folke/tokyonight.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins.
    init = function()
        -- load scheme here
        vim.cmd.colorscheme "tokyonight-night"
    end,
}
