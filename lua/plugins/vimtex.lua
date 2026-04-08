return {
    {
        "lervag/vimtex",
        lazy = false, -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        config = function()
            vim.g.tex_flavor = "latex"
            vim.g.vimtex_view_method = "zathura"

            -- Silence VimTeX output
            vim.g.vimtex_quickfix_mode = 0
            vim.g.vimtex_log_ignore = {
                "Underfull",
                "Overfull",
                "specifier changed to",
                "Token not allowed in a PDF string",
            }

            -- Enable continuous compilation
            vim.g.vimtex_compiler_method = "latexmk"

            vim.g.vimtex_compiler_latexmk = {
                continuous = 1, -- 🔑 auto build on save
                executable = "latexmk",
                options = {
                    "-pdf",
                    "-interaction=nonstopmode",
                    "-synctex=1",
                    "-silent",
                },
            }

            -- Optional but recommended
            vim.g.vimtex_view_automatic = 1

            vim.o.conceallevel = 1
            vim.g.tex_conceal = "abdmg"

            vim.g.vimtex_complete_enabled = 1
            vim.g.vimtex_include_search_enabled = 1
            vim.g.vimtex_include_search_suffixes = { "png", "jpg", "jpeg", "pdf", "eps" }
        end,
    },
}
