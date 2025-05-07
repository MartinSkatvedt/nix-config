return {
    "zbirenbaum/copilot.lua",
    event = "VeryLazy",
    keys = {
        {
            "<leader><CR>",
            "<cmd>Copilot suggestion accept<CR>",
            desc = "Copilot Accept Suggestion",
        },
        {
            "<M-]>",
            "<cmd>Copilot suggestion next<CR>",
            desc = "Copilot Next Suggestion",
        },
        {
            "<M-[>",
            "<cmd>Copilot suggestion prev<CR>",
            desc = "Copilot Prev Suggestion",
        },
        {
            "<C-]>",
            "<cmd>Copilot suggestion dismiss<CR>",
            desc = "Copilot Dismiss Suggestion",
        },
        {
            "[[",
            "<cmd>Copilot panel jump_prev<CR>",
            desc = "Copilot Jump Prev",
        },
        {
            "]]",
            "<cmd>Copilot panel jump_next<CR>",
            desc = "Copilot Jump Next",
        },
        {
            "gr",
            "<cmd>Copilot panel refresh<CR>",
            desc = "Copilot Refresh",
        },
        {
            "<M-o>",
            "<cmd>Copilot panel open<CR>",
            desc = "Copilot Open",
        },
    },
    config = function()
        require("copilot").setup({
            panel = {
                enabled = true,
                auto_refresh = false,
                keymap = {
                    jump_prev = "[[",
                    jump_next = "]]",
                    accept = "<CR>",
                    refresh = "gr",
                    open = "<M-o>"
                },
                layout = {
                    position = "bottom", -- | top | left | right
                    ratio = 0.4
                },
            },
            suggestion = {
                enabled = false,
                auto_trigger = true,
                hide_during_completion = true,
                debounce = 75,
                keymap = {
                    accept = "<leader><CR>",
                    accept_word = false,
                    accept_line = false,
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<C-]>",
                },
            },
            filetypes = {
                yaml = false,
                markdown = false,
                help = false,
                gitcommit = false,
                gitrebase = false,
                hgcommit = false,
                svn = false,
                cvs = false,
                ["."] = false,
            },
            copilot_node_command = 'node', -- Node.js version must be > 18.x
            server_opts_overrides = {},
        })
    end,
}
