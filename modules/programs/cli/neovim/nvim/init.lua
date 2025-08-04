vim.loader.enable()

local cmd = vim.cmd
local opt = vim.o

opt.path = vim.o.path .. '**'

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.lazyredraw = false -- Redraw screen when macros
opt.showmatch = true -- Highlight matching parentheses, etc
opt.incsearch = true
opt.hlsearch = true

opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.foldenable = true
opt.history = 2000
opt.nrformats = 'bin,hex' -- 'octal'
opt.undofile = true
-- opt.splitright = true
-- opt.splitbelow = true
-- opt.cmdheight = 0 -- Does not show command line

opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
opt.colorcolumn = '100'

-- Configure Neovim diagnostic messages

-- Native plugins
cmd.filetype('plugin', 'indent', 'on')
cmd.packadd('cfilter') -- Allows filtering the quickfix list with :cfdo

-- let sqlite.lua (which some plugins depend on) know where to find sqlite
vim.g.sqlite_clib_path = require('luv').os_getenv('LIBSQLITE')
