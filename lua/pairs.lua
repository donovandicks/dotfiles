return function()
  local success, pair = pcall(require, "nvim-autopairs")
  if not success then
    return
  end

  pair.setup({
    chars = { "{", "[", "(", "'", '"' },
    check_comma = true,
    check_ts = true,
    ts_config = {
      lua = { "string", "source" },
      javascript = { "string", "template_string" },
    },
  })
end

