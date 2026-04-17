return {
	{
		"williamboman/mason.nvim",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "pyright", "clangd", "rust_analyzer" },
			})

			local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/"

			vim.lsp.config("lua_ls", {
				cmd = { mason_bin .. "lua-language-server" },
				filetypes = { "lua" },
				settings = {
					Lua = { diagnostics = { globals = { "vim" } } }
				}
			})
			vim.lsp.config("pyright",       { cmd = { mason_bin .. "pyright-langserver", "--stdio" }, filetypes = { "python" } })
			vim.lsp.config("ts_ls",         { cmd = { mason_bin .. "typescript-language-server", "--stdio" }, filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" } })
			vim.lsp.config("clangd",        { cmd = { mason_bin .. "clangd" }, filetypes = { "c", "cpp", "objc", "objcpp" } })
			vim.lsp.config("rust_analyzer", { cmd = { mason_bin .. "rust-analyzer" }, filetypes = { "rust" } })

			vim.lsp.enable({ "lua_ls", "pyright", "ts_ls", "clangd", "rust_analyzer" })
		end,
	},
}
