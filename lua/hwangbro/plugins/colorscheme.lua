-- return {
--     "folke/tokyonight.nvim",
--     priority = 1000, -- make sure to load this before all the other start plugins.
--     init = function()
--         -- load scheme here
--         vim.cmd.colorscheme "tokyonight-night"
--     end,
-- }
--
return {
    "catppuccin/nvim",
    priority = 1000,
    name = "catppuccin",
    init = function()
        vim.cmd.colorscheme "catppuccin"
    end,
}
