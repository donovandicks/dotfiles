return function()
  vim.g.dashboard_default_executive = 'telescope'
  vim.g.indentLine_fileTypeExclude = {'dashboard'}

  -- vim.g.dashboard_custom_section = {
  --   find_dotfiles = {
  --     description = { '   Open Neovim Dotfiles' },
  --     command = 'lua require"telescope.builtin".find_files({ cwd = "~/.config/nvim" })'
  --   }
  -- }

  vim.g.dashboard_custom_header = {
    '',
    '',
    '',
    ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
    ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
    ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
    ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
    ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
    ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
    '',
  }
end
