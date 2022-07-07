local success, neotest = pcall(require, 'neotest')
if not success then
  return
end

neotest.setup({
  adapters = {
    require('neotest-python')
  }
})
