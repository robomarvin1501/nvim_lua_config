local ls = require('luasnip')
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- TODO switch to just lua files
ls.add_snippets("all", {
    s("iff", t("\\textbf{if and only if} ")),
    s("@la", t("\\lambda")),
    s("@de", t("\\delta")),
    s("@th", t("\\theta")),
    s("ov", fmt([[\overline{<>}<>]],
        {
            i(1, "overlined"), i(2, "")
        },
        {
            delimiters = "<>"
        })
    ),
    s("ipf", fmt([[\langle <>, <> \rangle <>]],
        {
            i(1, "lhs"), i(2, "rhs"), i(3, "")
        },
        {
            delimiters = "<>"
        })
    ),
    s("2b2", fmt([[\begin{bmatrix}
    <> & <> \\
    <> & <>
\end{bmatrix}]],
        {
            i(1, "a"), i(2, "b"), i(3, "c"), i(4, "d"),
        },
        {
            delimiters = "<>"
        })
    ),
    s("br", fmt([[\left(<>\right)<>]],
        {
            i(1, ""), i(2, ""),
        },
        {
            delimiters = "<>"
        })
    ),
    s("sbr", fmt([[\left[<>\right]<>]],
        {
            i(1, ""), i(2, ""),
        },
        {
            delimiters = "<>"
        })
    ),
    s("ssbr", fmt([[\left\{<>\right\}<>]],
        {
            i(1, ""), i(2, ""),
        },
        {
            delimiters = "<>"
        })
    ),
    s("inlmath", fmt([[$<>$<>]],
        {
            i(1, ""), i(2, ""),
        },
        {
            delimiters = "<>"
        })
    ),
    s("lim", fmt([[\displaystyle\lim_{<>}<>]],
        {
            i(1, ""), i(2, ""),
        },
        {
            delimiters = "<>"
        })
    ),
    s("bigcap", fmt([[\displaystyle\bigcap_{<>}^{<>}<>]],
        {
            i(1, ""), i(2, ""), i(3, "")
        },
        {
            delimiters = "<>"
        })
    ),
    s("bigcup", fmt([[\displaystyle\bigcup_{<>}^{<>}<>]],
        {
            i(1, ""), i(2, ""), i(3, "")
        },
        {
            delimiters = "<>"
        })
    ),
    s("cup", fmt([[\cup ]],
    {}, {})
    ),
    s("cap", fmt([[\cap ]],
    {}, {})
    ),
})

vim.keymap.set({ "i" }, "<C-k>", function() ls.expand() end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })
