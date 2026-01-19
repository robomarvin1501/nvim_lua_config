return {
    {
        "lervag/vimtex",
        lazy = false, -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        config = function()
            vim.g.tex_flavor = "latex"
            vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_quickfix_mode = 0
            vim.o.conceallevel = 1
            vim.g.tex_conceal = "abdmg"

            vim.g.vimtex_complete_enabled = 1
            vim.g.vimtex_include_search_enabled = 1
            vim.g.vimtex_include_search_suffixes = { "png", "jpg", "jpeg", "pdf", "eps" }

            vim.keymap.set("n", "<leader>li", function()
                return ":!make FILENAME=" .. vim.api.nvim_buf_get_name(0) .. "<CR>"
            end, { expr = true })

            vim.keymap.set("n", "<leader>lb", function()
                return ":!make build FILENAME=" .. vim.api.nvim_buf_get_name(0) .. "<CR>"
            end, { expr = true })

            vim.keymap.set("n", "<leader>lw", function()
                return vim.api.nvim_buf_get_name(0)
            end, { expr = true })
        end,
    },
}
