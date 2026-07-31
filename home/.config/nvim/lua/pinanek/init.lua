local plugin_manager = require("pinanek.plugin_manager")
local add, now, later = plugin_manager.bootstrap()

now(function()
  require("pinanek.options")
  require("pinanek.keybindings")
  require("pinanek.autocmds")
  require("pinanek.filetypes")
end)

now(function()
  add({ source = "catppuccin/nvim", name = "catppuccin" })
  require("catppuccin").setup({
    flavor = "catppuccin",
    color_overrides = { mocha = require("pinanek.color_scheme") },
  })

  vim.cmd.colorscheme("catppuccin")
end)

now(function()
  add({ source = "nvim-mini/mini.icons" })
  require("mini.icons").setup()
end)

now(function()
  add({ source = "nvim-mini/mini.statusline" })
  require("mini.statusline").setup()
end)

now(function()
  add({ source = "nvim-mini/mini.tabline" })
  require("mini.tabline").setup()
end)

now(function()
  add({ source = "nvim-mini/mini.starter" })
  require("mini.starter").setup()
end)

now(function()
  add({
    source = "nvim-treesitter/nvim-treesitter",
    hooks = {
      post_checkout = function()
        vim.cmd("TSUpdate")
      end,
    },
  })

  local filetypes = {
    "astro",
    "bash",
    "c",
    "css",
    "diff",
    "gotmpl",
    "html",
    "javascript",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "rust",
    "typescript",
    "vim",
    "vimdoc",
    "vue",
    "zsh",
  }
  require("nvim-treesitter").install(filetypes)

  vim.api.nvim_create_autocmd("FileType", {
    pattern = filetypes,
    callback = function()
      vim.treesitter.start()
    end,
  })
end)

later(function()
  add({ source = "neovim/nvim-lspconfig" })
  require("pinanek.lsp")
end)

later(function()
  add({ source = "folke/lazydev.nvim" })
  require("lazydev").setup({
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  })
end)

later(function()
  add({ source = "mrcjkb/rustaceanvim" })
end)

later(function()
  add({ source = "saghen/blink.cmp", checkout = "v1.10.2", depends = { "rafamadriz/friendly-snippets" } })
  require("blink.cmp").setup({
    keymap = {
      preset = "super-tab",
    },
    appearance = {
      nerd_font_variant = "normal",
    },
    completion = { documentation = { auto_show = true } },
    cmdline = {
      keymap = { preset = "inherit" },
      completion = { menu = { auto_show = true } },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      per_filetype = {
        lua = { inherit_defaults = true, "lazydev" },
      },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  })
end)

later(function()
  add({ source = "stevearc/conform.nvim" })
  require("conform").setup({
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff" },
      javascript = { "oxfmt", "prettier" },
      typescript = { "oxfmt", "prettier" },
    },
  })
end)

later(function()
  add({ source = "NMAC427/guess-indent.nvim" })
  require("guess-indent").setup({})
end)

later(function()
  add({ source = "folke/ts-comments.nvim" })
  require("ts-comments").setup()
end)

later(function()
  add({ source = "rachartier/tiny-inline-diagnostic.nvim" })
  require("tiny-inline-diagnostic").setup({
    preset = "minimal",
  })
end)

later(function()
  add({ source = "nvim-mini/mini.pairs" })
  require("mini.pairs").setup()
end)

later(function()
  add({ source = "folke/todo-comments.nvim", depends = { "nvim-lua/plenary.nvim" } })
  require("todo-comments").setup()
end)

later(function()
  add({ source = "lukas-reineke/indent-blankline.nvim" })
  require("ibl").setup()
end)

later(function()
  add({ source = "windwp/nvim-ts-autotag" })
  require("nvim-ts-autotag").setup()
end)

later(function()
  add({ source = "folke/which-key.nvim" })
  require("which-key").setup({
    preset = "helix",
  })
end)

later(function()
  add({ source = "ibhagwan/fzf-lua", depends = { "nvim-mini/mini.icons" } })

  local ignore_patterns = { ".git", "node_modules" }

  require("fzf-lua").setup({
    files = { file_ignore_patterns = ignore_patterns },
    grep = { file_ignore_patterns = ignore_patterns },
  })
end)

later(function()
  add({ source = "mikavilpas/yazi.nvim", depends = { "nvim-lua/plenary.nvim" } })
  require("yazi").setup({
    open_for_directories = true,
  })
end)
