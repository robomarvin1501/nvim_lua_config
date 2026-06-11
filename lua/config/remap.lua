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

function StartTypstWatchAndOpenZathura()
    if not RunningTypst then
        RunningTypst = true

        vim.cmd.vsplit()
        vim.cmd.wincmd("l")
        vim.cmd("vertical resize 20")
        vim.cmd("setlocal winfixwidth")

        local root = vim.loop.cwd()
        local file = vim.fn.expand("%:")
        local pdf = vim.fn.expand("%:r") .. ".pdf"

        -- Start typst watch in terminal
        vim.cmd("terminal typst watch --root " .. root .. " " .. file)

        -- Launch zathura (detached)
        -- vim.fn.jobstart({ "zathura", pdf }, { detach = true })
        open_zathura_when_ready(pdf)

        vim.cmd.wincmd("h")
    end
end

vim.keymap.set("n", "<leader>tw", StartTypstWatchAndOpenZathura)

vim.keymap.set("n", "<leader>fo", function()
    local root = vim.loop.cwd()
    local file = vim.fn.expand("%:")
    local pdf = vim.fn.expand("%:r") .. ".pdf"
    open_zathura_when_ready(pdf)
end)

-- Capitalise first letter of every word in selection
vim.keymap.set({ "n", "v" }, "<leader>cap", [[<cmd>s/\<./\u&/g<CR>]])
