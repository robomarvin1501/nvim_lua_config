local ls = require('luasnip')
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- TODO switch to just lua files
ls.add_snippets("all", {
    s("text", fmt([[\text{<>} <>]],
        {
            i(1, "text"), i(2, ""),
        },
        {
            delimiters = "<>",
        })
    ),
    s("gather", fmt([[\begin{gather*}
    <>
\end{gather*}<>]],
        {
            i(1, "text"), i(2, ""),
        },
        {
            delimiters = "<>",
        })
    ),
    s("@table3", fmt([[\begin{table}[h!]
     \centering
     \begin{tabular}{|c|c|c|}
         \hline
         <> & <> & <> \\ \hline
         <> & <> & <> \\ \hline
         <> & <> & <> \\ \hline
         <> & <> & <> \\ \hline
     \end{tabular}
     \caption{$\delta$}
 \end{table} <>]],
        {
            i(1, ""), i(2, ""), i(3, ""), i(4, ""), i(5, ""), i(6, ""), i(7, ""),
            i(8, ""), i(9, ""), i(10, ""), i(11, ""), i(12, ""), i(13, "")
        },
        {
            delimiters = "<>",
        })
    ),
    -- General maths
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
    s("iff", t("\\textbf{if and only if} ")),
    s("exercise", fmt([[\begin{exercise}
    <>
\end{exercise}]],
        { i(1, "") },
        { delimiters = "<>" })
    ),
    s("example", fmt([[\begin{example}[<>]
    <>
\end{example}]],
        { i(1, ""), i(2, "") },
        { delimiters = "<>" })
    ),
    s("exsol", fmt([[\begin{proof}[Solution]
    <>
\end{proof}]],
        { i(1, "") },
        { delimiters = "<>" })
    ),

    s("stackrel", fmt([[\stackrel{<>}{<>} <>]],
        {
            i(1, ""), i(2, ""), i(3, "")
        },
        {
            delimiters = "<>"
        })
    ),

    s("max", fmt([[\displaystyle\max_{<>} \left\{<>\right\} <>]],
        {
            i(1, ""), i(2, ""), i(3, "")
        },
        {
            delimiters = "<>"
        })
    ),

    s("min", fmt([[\displaystyle\min_{<>} \left\{<>\right\} <>]],
        {
            i(1, ""), i(2, ""), i(3, "")
        },
        {
            delimiters = "<>"
        })
    ),

    s("@hat", fmt([[\hat{<>} <>]],
        {
            i(1, ""), i(2, "")
        },
        {
            delimiters = "<>"
        })
    ),

    s("@tilde", fmt([[\widetilde{<>} <>]],
        {
            i(1, ""), i(2, "")
        },
        {
            delimiters = "<>"
        })
    ),

    s("sqrt", fmt([[\sqrt{<>} <>]],
        {
            i(1, ""), i(2, "")
        },
        {
            delimiters = "<>"
        })
    ),

    s("pilarge", fmt([[\displaystyle\prod_{<>}^{<>}<>]],
        {
            i(1, ""), i(2, ""), i(3, "")
        },
        {
            delimiters = "<>"
        })
    ),

    s("@curly", fmt([[\mathcal{<>} <>]],
        {
            i(1, ""), i(2, "")
        },
        {
            delimiters = "<>"
        })
    ),


    -- Greek
    s("@la", t("\\lambda")),
    s("@de", t("\\delta")),
    s("@th", t("\\theta")),
    s("@Om", t("\\Omega")),
    s("sig", t("\\sigma")),

    s("ov", fmt([[\overline{<>}<>]],
        {
            i(1, "overlined"), i(2, "")
        },
        {
            delimiters = "<>"
        })
    ),


    -- Linear Algebra
    s("ipf", fmt([[\left\langle <>, <> \right\rangle <>]],
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
    s("3b3", fmt([[\begin{bmatrix}
    <> & <> & <> \\
    <> & <> & <> \\
    <> & <> & <>
\end{bmatrix}]],
        {
            i(1, "a"), i(2, "b"), i(3, "c"), i(4, "d"),
            i(5, "e"), i(6, "f"), i(7, "g"), i(8, "h"), i(9, "i"),
        },
        {
            delimiters = "<>"
        })
    ),
    s("@vec", fmt([[\begin{bmatrix}
    <> \\
    \vdots \\
    <> \\
\end{bmatrix}]],
        {
            i(1, "a"), i(2, "b"),
        },
        {
            delimiters = "<>"
        })
    ),

    -- Brackets
    s("br", fmt([[\left(<>\right)<>]],
        {
            i(1, ""), i(2, ""),
        },
        {
            delimiters = "<>"
        })
    ),
    s("abr", fmt([[\left\langle <> \right\rangle<>]],
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
    s("abs", fmt([[\left|<>\right|<>]],
        {
            i(1, ""), i(2, ""),
        },
        {
            delimiters = "<>"
        })
    ),
    s("@floor", fmt([[\left\lfloor <> \right\rfloor <>]],
        {
            i(1, ""), i(2, ""),
        },
        {
            delimiters = "<>"
        })
    ),
    s("@ceil", fmt([[\left\lceil <> \right\rceil <>]],
        {
            i(1, ""), i(2, ""),
        },
        {
            delimiters = "<>"
        })
    ),


    -- Union and intersection
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

    -- Statistics
    s("probspace", fmt([[$\left(\Omega, \F, \p\right)$ ]],
        {}, {})
    ),

    s("disteq", fmt([[\stackrel{d}{=} ]], {}, { delimiters = "<>" })),
    s("distto", fmt([[\stackrel{d}{\to} ]], {}, { delimiters = "<>" })),
    s("defeq", fmt([[\stackrel{def}{=} ]], {}, { delimiters = "<>" })),
    s("aseq", fmt([[\stackrel{a.s}{=} ]], {}, { delimiters = "<>" })),
    s("binom", fmt([[\binom{<>}{<>} <>]], { i(1, ""), i(2, ""), i(3, "") }, { delimiters = "<>" })),

    -- IML
    s("@ht", fmt([[\mathcal{H}_{\Theta} ]], {}, { delimiters = "<>" })),
    s("@hatht", fmt([[\hat{\mathcal{H}}_{\Theta} ]], {}, { delimiters = "<>" })),
    s("@hatfs", fmt([[\hat{f}_S ]], {}, { delimiters = "<>" })),

    s("@diff", fmt([[\displaystyl\frac{d<>}{d<>}<> ]], { i(1, ""), i(2, ""), i(3, "") }, { delimiters = "<>" })),
    s("@partialdiff",
        fmt([[\displaystyle\frac{\partial <>}{\partial <>}<> ]], { i(1, ""), i(2, ""), i(3, "") }, { delimiters = "<>" })),

    -- OS
    s("@inlinecode", fmt([[\lstinline[columns=fixed]{<>}<>]], { i(1, "code"), i(2, "") }, { delimiters = "<>" })),
    s("@codeblock", fmt([[\begin{lstlisting}
    <>
\end{lstlisting}<>]], { i(1, "code"), i(2, "") }, { delimiters = "<>" })),

})

vim.keymap.set({ "i" }, "<C-k>", function() ls.expand() end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })
