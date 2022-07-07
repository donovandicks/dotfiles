local success, configs = pcall(require, 'nvim-treesitter.configs')
if not success then
  return
end

configs.setup({
  ensure_installed = {
    "python",
    "rust",
    "typescript",
    "javascript",
    "tsx",
    "java",
    "yaml",
    "toml",
    "json",
    "json5",
    "html",
    "jsdoc",
    "go",
    "dockerfile",
    "bash",
    "cmake",
    "make",
    "lua",
    "vim",
    "hcl",
  },
  sync_install = false,
  autopairs = {
    enable = true
  },
  indent = {
    enable = true
  },
  highlight = {
    enable = true,
    disable = { 'json' },
    additional_vim_regex_highlighting = true,
  },
  context_commentstring = {
    enable = true,
    enabled_autocmd = false,
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = {"BufWrite", "CursorHold"},
  },
})
