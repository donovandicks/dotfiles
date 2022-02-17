return function()
  require('nvim-treesitter.configs').setup({
    ensure_installed = "maintained",
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
end
