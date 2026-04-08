return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        main = "nvim-treesitter",
        opts = {
            auto_install = true,
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    -- Enable treesitter highlighting, and disable regex syntax
                    pcall(vim.treesitter.start)
                    -- Enable teresitter indentation
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })

            local ensure_installed = {
                "bash",
                "c",
                "diff",
                "html",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "query",
                "vim",
                "vimdoc",
            }

            local alread_installed = require("nvim-treesitter.config").get_installed()
            local parsers_to_install = vim.iter(ensure_installed)
                :filter(function(parser)
                    return not vim.tbl_contains(alread_installed, parser)
                end)
                :totable()
            require("nvim-treesitter").install(parsers_to_install)
        end,
    },
}
