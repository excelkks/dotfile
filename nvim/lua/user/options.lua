-- :help options
vim.opt.jumpoptions = stack
vim.opt.clipboard = unnamedplus
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.colorcolumn = "80"
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.cindent = true
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4
vim.opt.timeout = false
vim.opt.viewoptions = { "cursor", "folds", "slash", "unix" }
vim.opt.wrap = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.shortmess:append "c"

-- set formatoptions-=tc
vim.opt.lazyredraw = true
vim.opt.visualbell = false
vim.opt.laststatus = 3
vim.opt.virtualedit = "block"
vim.opt.mouse = "a"
vim.opt.cmdheight = 2
vim.opt.updatetime = 300
vim.opt.autochdir = true

vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.pumheight = 10
vim.opt.showmode = false
vim.opt.showtabline = 2
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.writebackup = false
vim.opt.signcolumn = "yes"
