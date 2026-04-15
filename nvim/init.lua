vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.clipboard = "unnamedplus"

vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/site")

require("config.lazy")
require("core")
