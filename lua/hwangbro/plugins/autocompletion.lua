return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        -- snippet engine & its associated nvim-cmp source
        {
            "L3MON4D3/LuaSnip",
            build = (function()
                -- Build step is needed for regex support in snippets.
                if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                    return
                end
                return "make install_jsregexp"
            end)(),
            dependencies = {
                -- `friendly-snippets` contains a variety of premade snippets
                -- {
                -- 'rafamadriz/friendly-snippets',
                -- config = function()
                -- require("luasnip.loaders.from_vscode").lazy_load()
                -- end,
                -- }
            },
        },
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        luasnip.config.setup({})

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = { completeopt = "menu,menuone,noinsert,noselect" },

            -- read :help ins-completion
            mapping = cmp.mapping.preset.insert({
                -- select the [n]ext item
                ["<C-n"] = cmp.mapping.select_next_item(),
                -- select the [p]revious item
                ["<C-p"] = cmp.mapping.select_prev_item(),

                -- scroll the documentation window [b]ack / [f]orward
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(-4),

                -- accept ([y]es) the completion.
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),

                -- more traditional mapping
                -- ["<CR>"] = cmp.mapping.confirm({ select = true }),
                -- ["<Tab>"] = cmp.mapping.select_next_item(),
                -- ["<S-Tab>"] = cmp.mapping.select_prev_item(),

                -- manuallly trigger a completion from nvim-cmp
                ["<C-Space>"] = cmp.mapping.complete({}),

                -- think of <C-l> as moving to the right of your snippet expansion.
                ["<C-l>"] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { "i", "s" }),
                ["<C-h>"] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1)() then
                        luasnip.jump(-1)
                    end
                end, { "i", "s" }),
            }),
            sources = {
                {
                    name = "lazydev",
                    group_index = 0,
                },
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "path" },
                { name = "nvim_lsp_signature_help" }
            },
        })
    end,
}
