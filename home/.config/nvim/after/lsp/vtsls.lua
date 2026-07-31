local uv = vim.uv or vim.loop

local function exists(p)
  return p and uv.fs_stat(p) ~= nil
end

local function find_vue_ls_from_mise()
  local bin = vim.fn.trim(vim.fn.system({ "mise", "which", "vue-language-server" }))
  if bin == "" or vim.v.shell_error ~= 0 then
    return nil
  end
  local real = uv.fs_realpath(bin) or bin
  return vim.fs.dirname(vim.fs.dirname(real))
end

local function find_vue_ls_from_project_node_modules()
  local p = vim.fn.getcwd() .. "/node_modules/@vue/language-server"
  return exists(p) and p or nil
end

local vue_ls_path = find_vue_ls_from_mise() or find_vue_ls_from_project_node_modules()

local filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
local globalPlugins = {}

if vue_ls_path then
  table.insert(filetypes, "vue")
  table.insert(globalPlugins, {
    name = "@vue/typescript-plugin",
    location = vue_ls_path,
    languages = { "vue" },
    configNamespace = "typescript",
  })
end

return {
  filetypes = filetypes,
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = globalPlugins,
      },
    },
  },
}
