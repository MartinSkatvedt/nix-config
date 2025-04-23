return
{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()

        local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
        vim.fn.mkdir(parser_install_dir, "p")

        -- Prevents reinstall of treesitter plugins every boot
        vim.opt.runtimepath:append(parser_install_dir)

        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "html", "go", "typescript", "nix" },
            sync_install = true,
            highlight = { enable = true },
            indent = { enable = true },

            parser_install_dir = parser_install_dir
        })
    end
}
