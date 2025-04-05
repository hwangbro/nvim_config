vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.guicursor = ""

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.g.have_nerd_font = false

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.showmode = false

vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250

vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.inccommand = "split"

vim.opt.cursorline = true

vim.opt.scrolloff = 8

-- trim trailing whitespace on save
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("trim_whitespaces", { clear = true }),
    desc = "Trim trailing white spaces",
    pattern = "*",
    callback = function()
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "<buffer>",
            -- trim
            callback = function()
                -- save cursor position to restore later
                local curpos = vim.api.nvim_win_get_cursor(0)
                -- search and replace trailing whitespaces
                vim.cmd([[keeppatterns %s/\s\+$//e]])
                vim.api.nvim_win_set_cursor(0, curpos)
            end,
        })
    end,
})

-- keymaps
require("hwangbro.remap")

require("hwangbro.lazy")
require("hwangbro.lsp")
