return function()
  local success, indent = pcall(require, "indent_blankline")
  if not success then
    return
  end

  vim.g.indentLine_enabled = 1
  vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
  vim.g.indent_blankline_filetype_exclude = { "help" }

  indent.setup({
    char = "¦",
    use_treesitter = true,
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    context_patterns = {
      "class",
      "return",
      "function",
      "method",
      "^if",
      "^while",
      "^for",
      "if_statement",
      "else_clause",
      "object",
      "try_statement",
      "catch_clause",
      "block",
      "arguments",
      "operation_type",
      "^match",
      "import_statement",
      "use_statement",
      "^table",
    }
  })
end
