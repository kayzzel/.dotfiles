local opt = vim.opt
local hl = vim.api.nvim_set_hl

-- file
opt.swapfile = false
opt.undofile = true

-- lines
opt.number = true
opt.relativenumber = true
opt.cursorline = true

-- tabs & indent
opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.backspace = "indent,eol,start"

vim.opt.termguicolors = true

vim.opt.laststatus = 0
hl(0, "StatusLine", { bg = "none" })
hl(0, "StatusLineNC", { bg = "none" })
hl(0, "CursorLine", { bg = "none" })
hl(0, "Visual",     { bg = "#6c4791", blend = 10 })

