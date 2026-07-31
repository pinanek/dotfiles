--  Stolen from kickstart.nvim

local map = vim.keymap.set

-- del("n", "gN")

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Move line up and down
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line up" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line down" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line up" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line down" })

-- Select all
map("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Buffer
map("n", "<leader>f", function()
  require("conform").format({ async = true })
end, { desc = "Buffer: Format" })

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach-keybindings", { clear = true }),
  callback = function(event)
    -- Rename
    map("n", "<leader>r", vim.lsp.buf.rename, {
      buffer = event.buf,
      desc = "LSP: Rename symbol",
    })

    -- Code action (normal + visual)
    map({ "n", "x" }, "<leader>a", vim.lsp.buf.code_action, {
      buffer = event.buf,
      desc = "LSP: Code action",
    })

    map("n", "gd", vim.lsp.buf.definition, {
      buffer = event.buf,
      desc = "LSP: Goto definition",
    })

    map("n", "gD", vim.lsp.buf.declaration, {
      buffer = event.buf,
      desc = "LSP: Goto declaration",
    })

    map("n", "<leader>s", "<cmd>FzfLua lsp_document_symbols<cr>", {
      buffer = event.buf,
      desc = "LSP: Document symbols",
    })

    map("n", "<leader>S", "<cmd>FzfLua lsp_workspace_symbols<cr>", {
      buffer = event.buf,
      desc = "LSP: Workspace symbols",
    })

    map("n", "<leader>d", "<cmd>FzfLua lsp_document_diagnostics<cr>", {
      buffer = event.buf,
      desc = "LSP: Document diagnostics",
    })

    map("n", "<leader>D", "<cmd>FzfLua lsp_workspace_diagnostics<cr>", {
      buffer = event.buf,
      desc = "LSP: Workspace diagnostics",
    })

    -- Inlay hints toggle (if supported)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method("textDocument/inlayHint", event.buf) then
      map("n", "<leader>i", function()
        local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
        vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
      end, {
        buffer = event.buf,
        desc = "LSP: Toggle inlay hints",
      })
    end
  end,
})

-- Pickers
map("n", "<leader>e", "<cmd>FzfLua files<cr>", { desc = "Picker: Files" })
map("n", "<leader>b", "<cmd>FzfLua buffers<cr>", { desc = "Picker: Buffers" })
map("n", "<leader>g", "<cmd>FzfLua lgrep_curbuf<cr>", { desc = "Picker: Grep current buffer" })
map("n", "<leader>G", "<cmd>FzfLua live_grep_native<cr>", { desc = "Picker: Grep current project" })

-- File explorer
map("n", "<leader>E", "<cmd>Yazi<cr>", { desc = "File explorer: Open at current file" })
