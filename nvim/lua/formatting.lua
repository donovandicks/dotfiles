local success, formatter = pcall(require, 'formatter')
if not success then
  return
end

formatter.setup({
  filetype = {
    python = {
      require('formatter.filetypes.python').black,
    },
    lua = {
      require('formatter.filetypes.lua').stylua,
    }
  }
})

