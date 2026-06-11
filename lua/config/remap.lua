vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

vim.keymap.set("i", "<C-d>", "<C-k>")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", ":W", ":w")
vim.keymap.set("n", ":Q", ":q")

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>/", [[/\<<C-r><C-w>\>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>")
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

local function eval_visual_selection_with_bc()
    if vim.fn.executable("bc") == 0 then
        vim.notify("bc is not installed or not found in PATH", vim.log.levels.ERROR)
        return
    end

    local visual_mode = vim.fn.mode()

    -- In case this is ever called after leaving visual mode.
    if visual_mode ~= "v" and visual_mode ~= "V" and visual_mode ~= "\22" then
        visual_mode = vim.fn.visualmode()
    end

    if visual_mode == "\22" then
        vim.notify("bc evaluation does not support visual block mode", vim.log.levels.ERROR)
        return
    end

    local opts = {
        type = visual_mode,
        exclusive = false,
        eol = true,
    }

    local start_pos = vim.fn.getpos("v")
    local end_pos = vim.fn.getpos(".")

    local selected_lines = vim.fn.getregion(start_pos, end_pos, opts)
    local region = vim.fn.getregionpos(start_pos, end_pos, opts)

    if #selected_lines == 0 or #region == 0 then
        vim.notify("No visual selection found", vim.log.levels.WARN)
        return
    end

    table.insert(selected_lines, 1, "scale = 4")
    local input = table.concat(selected_lines, "\n")
    if not input:match("\n$") then
        input = input .. "\n"
    end

    -- Typst multiplication
    input = input:gsub(" dot ", " * ")
    input = input:gsub(" times ", " * ")

    local ok, job = pcall(vim.system, { "bc", "-l" }, {
        stdin = input,
        text = true,
    })

    if not ok then
        vim.notify("Failed to run bc: " .. tostring(job), vim.log.levels.ERROR)
        return
    end

    local result = job:wait(3000)

    if result.code ~= 0 or (result.stderr and result.stderr ~= "") then
        local err = result.stderr or ("bc exited with code " .. tostring(result.code))
        vim.notify("bc error:\n" .. err, vim.log.levels.ERROR)
        return
    end

    local output = result.stdout or ""
    output = output:gsub("\r\n", "\n")
    output = output:gsub("\n+$", "")
    output = output:gsub("(%d+%.%d*[1-9])0+$", "%1")
    output = output:gsub("%.0+$", "")

    if output == "" then
        vim.notify("bc produced no output; not replacing selection", vim.log.levels.WARN)
        return
    end

    local replacement = vim.split(output, "\n", { plain = true })

    local bufnr = 0

    if visual_mode == "V" then
        -- Linewise visual selection: replace complete selected lines.
        local start_lnum = region[1][1][2]
        local end_lnum = region[#region][1][2]

        vim.api.nvim_buf_set_lines(bufnr, start_lnum - 1, end_lnum, false, replacement)
    else
        -- Characterwise visual selection: replace exact selected byte range.
        local first = region[1][1]
        local last = region[#region][2]

        local start_row = first[2] - 1
        local start_col = math.max(first[3] - 1, 0)

        local end_row = last[2] - 1
        local end_line = vim.api.nvim_buf_get_lines(bufnr, end_row, end_row + 1, true)[1] or ""
        local end_col = math.min(last[3], #end_line)

        vim.api.nvim_buf_set_text(bufnr, start_row, start_col, end_row, end_col, replacement)
    end
end

vim.keymap.set("x", "<leader>bc", eval_visual_selection_with_bc, {
    desc = "Evaluate visual selection with bc",
    silent = true,
})

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

vim.keymap.set("n", "<leader>b", function()
    local filename = vim.fn.expand("%:t") -- get file name
    local basename = vim.fn.expand("%:r") -- base without extension
    local ext = vim.fn.expand("%:e")   -- get extension

    if ext == "cpp" then
        vim.cmd("e " .. basename .. ".h")
    elseif ext == "h" then
        vim.cmd("e " .. basename .. ".cpp")
    else
        print("Not a .cpp or .h file.")
    end
end)

function GitRoot()
    local git_dir = vim.fs.find(".git", {
        upward = true,
        type = "directory",
    })[1]

    if not git_dir then
        return nil
    end

    return vim.fs.dirname(git_dir)
end

local function open_zathura_when_ready(pdf)
    vim.defer_fn(function()
        if vim.loop.fs_stat(pdf) then
            vim.fn.jobstart({ "zathura", pdf }, { detach = true })
        else
            open_zathura_when_ready(pdf)
        end
    end, 300)
end

typst_watch_job = nil
function StartTypstWatch(bufnr)
    if typst_watch_job then
        return
    end

    local file = vim.api.nvim_buf_get_name(bufnr)
    local root = vim.loop.cwd()
    local pdf = vim.fn.fnamemodify(file, ":r") .. ".pdf"

    typst_watch_job = vim.fn.jobstart({ "typst", "watch", "--root", root, file }, {
        on_exit = function()
            typst_watch_job = nil
        end,
    })

    open_zathura_when_ready(pdf)
end

vim.keymap.set("n", "<leader>fo", function()
    local root = vim.loop.cwd()
    local file = vim.fn.expand("%:")
    local pdf = vim.fn.expand("%:r") .. ".pdf"
    open_zathura_when_ready(pdf)
end)

-- Capitalise first letter of every word in selection
vim.keymap.set({ "n", "v" }, "<leader>cap", [[<cmd>s/\<./\u&/g<CR>]])
