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

-- lint

local ok, lint = pcall(require, "lint")
if ok then
    if vim.fn.executable("flake8") == 1 then
      lint.linters_by_ft.python = lint.linters_by_ft.python or {}
      table.insert(lint.linters_by_ft.python, "flake8")
    end

    if vim.fn.executable("mypy") == 1 then
      lint.linters_by_ft.python = lint.linters_by_ft.python or {}
      table.insert(lint.linters_by_ft.python, "mypy")

      local mypy = lint.linters.mypy
      mypy.args = vim.list_extend(
          mypy.args or {},
          { "--cache-dir=/dev/null" }
      )
    end

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "BufReadPost", "BufNewFile" }, {
      callback = function()
        -- ne lancer lint que si le fichier a un linter configuré
        local ft = vim.bo.filetype
        if lint.linters_by_ft[ft] then
          lint.try_lint()
        end
      end,
    })

    vim.diagnostic.config({
      virtual_text = {
        prefix = "▎"--, "✖"
      },
      signs = true,
      underline = false,
      update_in_insert = false,
      severity_sort = true,
    })

    vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#ff5555" })
    vim.api.nvim_set_hl(0, "DiagnosticWarn",  { fg = "#ff5555" })
    -- vim.api.nvim_set_hl(0, "DiagnosticWarn",  { fg = "#f1fa8c" })

    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#ff6c6b" })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn",  { fg = "#ff6c6b" })
    --vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn",  { fg = "#ECBE7B" })
end
