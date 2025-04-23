return
{
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    keys = {
        { "<C-t>",     "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
        { "<leader>f", "<cmd>NvimTreeFocus<cr>",  desc = "Focus NvimTree" }
    },
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup {}
    end,
}
