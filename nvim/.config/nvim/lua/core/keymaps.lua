-- Leader key
local keymap = vim.keymap.set

-- Normal
keymap("n", "<leader>w", "<CMD>w<CR>", {desc = "save file"})
keymap("n", "<leader>q", "<CMD>q<CR>", {desc = "quit vim"})

-- Oil
keymap("n" , "<leader>md", "<CMD>Oil<CR>", {desc = "Start Oil"})

-- 42Header
keymap("n" , "<leader>h", "<CMD>Stdheader<CR>", {desc = "Insert 42 header"})

-- Telescope
--keymap("n", "<space>fr", require('telescope.builtin').lsp_references)
keymap("n", "<space>fb", require('telescope.builtin').buffers)
keymap("n", "<space><space>", require('telescope.builtin').find_files)
keymap("n", "<space>en", function()
	require('telescope.builtin').find_files {
		cwd = vim.fn.stdpath("config")
	}
	end
)

-- Toggleterm
keymap("n", "<space>t", "<CMD>ToggleTerm<CR>", {desc = "Toggle floating terminal"})

-- Flake8
keymap("n", "<space>8", "<CMD>call flake8#Flake8()<CR>")

-- W3m
vim.keymap.set("n", "<leader>s", function()
  vim.ui.input({ prompt = "Search: " }, function(input)
    if not input or input == "" then return end
	vim.cmd("enew")
    local keys = vim.api.nvim_replace_termcodes(
      ":W3m " .. input .. "<CR>",
      true, false, true
    )
    vim.api.nvim_feedkeys(keys, "n", false)
  end)
end)
