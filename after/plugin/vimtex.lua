vim.g.tex_flavor = 'latex'
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_mode = 0
vim.o.conceallevel = 1
vim.g.tex_conceal = 'abdmg'

vim.keymap.set("n", "<leader>li", string.format(":!make FILENAME=%s<CR>", vim.fn.expand("%:p")));
