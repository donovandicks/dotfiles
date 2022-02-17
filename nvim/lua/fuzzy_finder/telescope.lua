return function()
  require('telescope').setup({
    defaults = {
      vimgrep_arguments = {
        'rg',
        '--with-filename',
        '--line-number',
        '--column',
      },
      initial_mode = 'normal',
      file_ignore_patterns = { 'node_modules/.*', '%.env' },
    }
  })

  vim.api.nvim_set_keymap('n', '<space>ff', '<cmd>lua require("telescope.builtin").find_files({ search_dirs = { "~/Projects" } })<cr>', { silent = true })
  vim.api.nvim_set_keymap('n', '<space>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', { silent = true })
  vim.api.nvim_set_keymap('n', '<space>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', { silent = true })
  vim.api.nvim_set_keymap('n', '<space>fn', '<cmd>lua require("telescope.builtin").help_tags()<cr>', { silent = true })
end
