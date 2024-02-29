vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.clipboard = 'unnamedplus'

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- vim.api.nvim_set_option("clipboard","unnamed")

vim.o.number = true
vim.o.relativenumber = true

vim.o.smartindent = true
vim.o.smartcase = true
vim.o.expandtab = true

vim.o.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.o.signcolumn = 'yes'

vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.updatetime = 50

vim.o.scrolloff = 8

vim.o.colorcolumn = "80"

vim.o.termguicolors = true

vim.o.mouse = 'a'

vim.cmd("command! -nargs=0 W w") --I keep holding shift when trying to save.... sadge.
