-- In ~/.config/nvim/lua/plugins/blink.lua
return {
  "saghen/blink.cmp",
  version = "*",  -- use a release tag so it doesn't break on updates
  opts = {
    keymap = {
      preset = "default",
      -- default bindings:
      -- <C-space> to open completion
      -- <C-n>/<C-p> or <Up>/<Down> to navigate
      -- <CR> or <Tab> to confirm
      -- <C-e> to close
    },

    appearance = {
      nerd_font_variant = "mono",  -- remove this if you don't use a nerd font
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    completion = {
      -- show documentation popup alongside completion menu
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },

      -- automatically show completion menu as you type
      trigger = {
        show_on_insert_enter = true,
      },

      -- accept the full LSP suggestion including autoimport edits
      accept = {
        auto_brackets = { enabled = true },
      },
    },

    signature = {
      enabled = true,  -- shows function signature hints (replaces lsp_signature.nvim)
    },
  },
}
