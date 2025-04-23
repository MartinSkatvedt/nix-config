return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        --event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-buffer',           -- source for text in buffer
            'hrsh7th/cmp-path',             -- source for file system paths
            'L3MON4D3/LuaSnip',             -- snippet engine
            'saadparwaiz1/cmp_luasnip',     -- for autocompletion
            'rafamadriz/friendly-snippets', -- useful snippets
            'onsails/lspkind.nvim',         -- vs-code like pictograms
            'hrsh7th/cmp-cmdline',
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()


            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()

            local lspkind = require('lspkind')

            cmp.setup({
                formatting = {
                    -- lsp_zero.cmp_format({ details = true }),
                    format = lspkind.cmp_format()
                },
                mapping = cmp.mapping.preset.insert({
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                    ['<Tab>'] = cmp_action.luasnip_supertab(),
                    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
                }),
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                view = {
                    entries = { name = 'custom', selection_order = 'near_cursor' }
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- snippets
                    { name = 'buffer' },  -- text within current buffer
                    { name = 'path' },    -- file system paths
                }
            })


            -- `:` cmdline setup.
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' },
                }, {
                    {
                        name = 'cmdline',
                        option = {
                            ignore_cmds = { 'Man', '!' },
                        },
                    },
                }),
            })
        end,
        opts = function()
            return {
                formatting = {
                    format = require('lspkind').cmp_format({
                        before = require('tailwind-tools.cmp').lspkind_format
                    }),
                }
            }
        end
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')

            lsp_zero.extend_lspconfig()

            -- if you want to know more about mason.nvim
            -- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })
                lsp_zero.buffer_autoformat()
            end)

            lsp_zero.set_sign_icons({
                error = '✘',
                warn = '',
                hint = '⚑',
                info = '»'
            })


            require('mason-lspconfig').setup({
                ensure_installed = {},
                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,

                    -- this is the "custom handler" for `lua_ls`
                    lua_ls = function()
                        -- (Optional) Configure lua language server for neovim
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
                    end,
                }
            })
        end
    },

    -- tailwind-tools.lua
    {
        "luckasRanarison/tailwind-tools.nvim",
        name = "tailwind-tools",
        build = ":UpdateRemotePlugins",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope.nvim", -- optional
            "neovim/nvim-lspconfig",         -- optional
        },
        opts = {}                            -- your configuration
    },
    {
        'stevearc/conform.nvim',
        opts = {},
        config = function()
            require('conform').setup({
                formatters_by_ft = {
                    lua             = { "stylua" },
                    -- Conform will run multiple formatters sequentially
                    python          = { "isort", "black" },
                    -- You can customize some of the format options for the filetype (:help conform.format)
                    rust            = { "rustfmt", lsp_format = "fallback" },
                    -- Conform will run the first available formatter
                    javascript      = { "prettierd", "prettier", stop_after_first = true },
                    typescript      = { "prettierd", "prettier", stop_after_first = true },
                    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
                    asm             = { "asmfmt" },
                    assembly        = { "asmfmt" },
                    nix             = { "nixfmt" },
                },
                format_on_save = {
                    timeout_ms = 500,
                    lsp_format = "fallback"
                }
            })
        end
    }
}
