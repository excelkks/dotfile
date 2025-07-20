vim.opt.jumpoptions = 'stack'
vim.opt.clipboard = 'unnamedplus'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.colorcolumn = '100'
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 0   -- 0 means the same as tabstop
vim.opt.softtabstop = 2
vim.opt.autoindent = true
vim.opt.cindent = true
-- vim.opt.foldmethod = 'indent'
vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",       -- 制表符显示为 →（后面有个空格）
  trail = ".",      -- 行尾空格显示为 ·
  extends = "»",    -- 行超出右边界时显示 »
  precedes = "«",   -- 行超出左边界时显示 «
  nbsp = "␣",       -- 不可断空格显示为 ␣
}
vim.opt.scrolloff = 4
vim.opt.timeout = false
vim.opt.wrap = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.hlsearch = true
vim.opt.incsearch = false
-- vim.opt.showmode = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- vim.opt.inccommand = 'split'
vim.opt.shortmess:append('mrwc')
-- vim.opt.lazyredraw = true
vim.opt.laststatus = 3
vim.opt.virtualedit = 'block'
vim.opt.mouse = 'a'
vim.opt.cmdheight = 2
vim.opt.updatetime = 300
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.termguicolors= true
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.writebackup = false
vim.opt.signcolumn = "yes"

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local mark_line = vim.fn.line("'\"")
    local last_line = vim.fn.line("$")
    if mark_line > 1 and mark_line <= last_line then
      vim.cmd("normal! g'\"")
    end
  end,
})

