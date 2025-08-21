return {
    { -- You can easily change to a different colorscheme.
        -- Change the name of the colorscheme plugin below, and then
        -- change the command in the config to whatever the name of that colorscheme is.
        --
        -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
        'ellisonleao/gruvbox.nvim',
        priority = 1000, -- Make sure to load this before all the other start plugins.
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require('gruvbox').setup {
                overides = {
                    normal = { bg = "#000000" },
                },
                styles = {
                    disable_background = true,
                    terminal_colors = true,
                    undercurl = true,
                    underline = true,
                    bold = true,
                    italic = {
                        strings = true,
                        emphasis = true,
                        comments = true,
                        operators = false,
                        folds = true,
                    },
                    strikethrough = true,
                    invert_selection = false,
                    invert_signs = false,
                    invert_tabline = false,
                    invert_intend_guides = false,
                    inverse = true, -- invert background for search, diffs, statuslines and errors
                    contrast = "",  -- can be "hard", "soft" or empty string
                    palette_overrides = {},
                    overrides = {},
                    dim_inactive = false,
                    transparent_mode = false,
                },
            }
            vim.o.background = "dark"

            -- Load the colorscheme here.
            -- Like many other themes, this one has different styles, and you could load
            -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
            vim.cmd.colorscheme 'gruvbox'
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end,
    }
}
