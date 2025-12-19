local opt = vim.opt

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

vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
vim.api.nvim_set_hl(0, "Visual",     { bg = "#6c4791", blend = 10 })
vim.api.nvim_set_hl(0, "Cursor", {
  bg = "#7a7a7a",
  fg = "#422d57",
})
