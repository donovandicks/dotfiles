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
    playgound = {
      enable = true,
      disable = { },
      updatetime = 25,
      persist_queries = false,
      keybindings = {
        toggle_query_editor = 'o',
        toggle_hl_groups = 'i',
        toggle_injected_languages = 't',
        toggle_anonymous_nodes = 'a',
        toggle_language_display = 'I',
        focus_language = 'f',
        unfocus_language = 'F',
        update = 'R',
        goto_node = '<cr>',
        show_help = '?',
      },
    },
    query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = {"BufWrite", "CursorHold"},
    },
  })
end
