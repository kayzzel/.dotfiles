return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    ft = { "markdown" },
    build = "cd app && npm install",
    keys = {
        { "<space>m", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle Markdown Preview" },
    },
    config = function()
        -- Browser to open the preview in (default: your system default)
        -- vim.g.mkdp_browser = "firefox"

        -- Open preview when entering a markdown buffer
        vim.g.mkdp_auto_start = 0

        -- Close preview when leaving the markdown buffer
        vim.g.mkdp_auto_close = 1

        -- Refresh only on save or leaving insert mode (0 = refresh as you type)
        vim.g.mkdp_refresh_slow = 0

        -- Only allow one preview window at a time
        vim.g.mkdp_combine_preview = 1

        -- Preview server port (0 = random available port)
        vim.g.mkdp_port = ""

        -- Preview page title: use the filename
        vim.g.mkdp_page_title = "${name}"

        -- Theme: "dark" or "light" — follows your terminal background
        vim.g.mkdp_theme = "dark"

        -- Custom CSS (optional — leave empty to use default)
        vim.g.mkdp_markdown_css = ""

        -- Filetypes that can trigger the preview
        vim.g.mkdp_filetypes = { "markdown" }
    end,
}
