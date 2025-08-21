return {
    {
        "lervag/vimtex",
        lazy = false, -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        config = function()
            vim.g.tex_flavor = 'latex'
            vim.g.vimtex_view_method = 'zathura'
            vim.g.vimtex_quickfix_mode = 0
            vim.o.conceallevel = 1
            vim.g.tex_conceal = 'abdmg'

            vim.keymap.set("n", "<leader>li", string.format(":!make FILENAME=%s<CR>", vim.api.nvim_buf_get_name(0)));
            vim.keymap.set("n", "<leader>lb", string.format(":!make build FILENAME=%s<CR>", vim.fn.expand("%:p")));
            vim.keymap.set("n", "<leader>lw", vim.api.nvim_buf_get_name(0));
        end
    }
}
