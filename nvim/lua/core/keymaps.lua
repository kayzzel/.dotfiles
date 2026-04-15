-- Leader key
local keymap = vim.keymap.set

-- Normal
keymap("n", "<leader>w", "<CMD>w<CR>", {desc = "save file"})
keymap("n", "<leader>q", "<CMD>q<CR>", {desc = "quit vim"})

keymap("n", "<C-k>", "V:move '<-2<CR>gv-gv<ESCAPE>", { desc = "Déplace le texte vers le haut" })
keymap("n", "<C-j>", "V:move '>+1<CR>gv-gv<ESCAPE>", { desc = "Déplace le texte vers le bas"})
keymap("x", "<C-k>", ":move '<-2<CR>gv-gv", { desc = "Déplace le texte vers le haut" })
keymap("x", "<C-j>", ":move '>+1<CR>gv-gv", { desc = "Déplace le texte vers le bas"})

keymap("n", "<C-u>", "<C-u>zz", { desc = "Go up half a page and center the screen"})
keymap("n", "<C-d>", "<C-d>zz", { desc = "Go down half a page and center the screen"})


keymap("n" , "<leader>ut", "<CMD>UndotreeToggle<CR>", {desc = "toggle undotree"})
-- Oil
keymap("n" , "<leader>md", "<CMD>Oil<CR>", {desc = "Start Oil"})

-- 42Header
keymap("n" , "<leader>h", "<CMD>Stdheader<CR>", {desc = "Insert 42 header"})

-- Custom folding keybind
keymap("n", "<leader>:", "zc", { desc = "Close Fold" })
keymap("n", "<leader>;", "za", { desc = "togle Fold" })

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

-- Search for the symbol under the cursor
vim.keymap.set("n", "<leader>gd", function()
  local word = vim.fn.expand("<cword>")
  require("telescope.builtin").live_grep({ default_text = word })
end, { desc = "Go to Definition (grep)" })

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

-- Markdown
keymap("n", "<space>m", "<cmd>MarkdownPreviewToggle<cr>", opts)

-- Coller sans écraser le registre
keymap("v", "<leader>p", '"_dP')
