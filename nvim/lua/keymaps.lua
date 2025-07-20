-- Shorten function name
local keymap = vim.keymap.set

local function noremap(lhs, rhs)
    keymap("", lhs, rhs, { noremap = true, silent = true })
end

local function nnoremap(lhs, rhs)
    keymap("n", lhs, rhs, { noremap = true, silent = true })
end

local function inoremap(lhs, rhs)
    keymap("i", lhs, rhs, { noremap = true, silent = true })
end

local function vnoremap(lhs, rhs)
    keymap("v", lhs, rhs, { noremap = true, silent = true })
end

local function xnoremap(lhs, rhs)
    keymap("x", lhs, rhs, { noremap = true, silent = true })
end

local function tnoremap(lhs, rhs)
    keymap("t", lhs, rhs, { silent = true })
end

local function wsplit(dir)
    vim.ui.input({ prompt = "split open: ", completion = "file" }, function(name)
        if name == nil then
            return nil
        else
            if dir == "up" then
                vim.opt.splitbelow = false
                vim.cmd("split " .. name)
                vim.opt.splitbelow = true
            elseif dir == "down" then
                vim.opt.splitbelow = true
                vim.cmd("split " .. name)
            elseif dir == "left" then
                vim.opt.splitright = false
                vim.cmd("vsplit " .. name)
                vim.opt.splitright = true
            elseif dir == "right" then
                vim.opt.splitright = true
                vim.cmd("vsplit " .. name)
            else
                error("invalid split directory " .. dir)
            end
        end
    end)
end

-- Remap space as leader key
noremap("<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- open init.lua
local config_file = vim.fn.stdpath("config")
nnoremap("<Leader>rc", ":e " .. config_file .. "<CR>")

-- split window
nnoremap("sh", function() wsplit("left") end)
nnoremap("sj", function() wsplit("down") end)
nnoremap("sk", function() wsplit("up") end)
nnoremap("sl", function() wsplit("right") end)

-- window navigation
nnoremap("<leader>h", "<C-w>h")
nnoremap("<leader>j", "<C-w>j")
nnoremap("<leader>k", "<C-w>k")
nnoremap("<leader>l", "<C-w>l")

nnoremap("<leader>e", ":Lex 30<cr>")

-- Resize with arrows
nnoremap("<C-Up>", ":resize +2<CR>")
nnoremap("<C-Down>", ":resize -2<CR>")
nnoremap("<C-Left>", ":vertical resize -2<CR>")
nnoremap("<C-Right>", ":vertical resize +2<CR>")

-- Navigate buffers
nnoremap("<S-l>", ":bnext<CR>")
nnoremap("<S-h>", ":bprevious<CR>")

-- Insert
-- Press jk fast to enter
inoremap("jk", "<ESC>")

-- Visual
-- Stay in indent mode
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Move test up and down
vnoremap("<A-j>", ":m .+1<CR>==")
vnoremap("<A-k>", ":m .-2<CR>==")
vnoremap("p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
xnoremap("J", ":move '>+1<CR>gv-gv")
xnoremap("K", ":move '<-2<CR>gv-gv")
xnoremap("<A-j>", ":move '>+1<CR>gv-gv")
xnoremap("<A-k>", ":move '<-2<CR>gv-gv")

-- Terminal
-- Better terminal navigation
tnoremap("<C-h>", "<C-\\><C-N><C-w>h")
tnoremap("<C-j>", "<C-\\><C-N><C-w>j")
tnoremap("<C-k>", "<C-\\><C-N><C-w>k")
tnoremap("<C-l>", "<C-\\><C-N><C-w>l")
tnoremap("<C-o>", "<C-\\><C-N>")
