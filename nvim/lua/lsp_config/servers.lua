function load_plugin(plugin_name)
  local success, plugin = pcall(require, plugin_name)
  if not success then
    error()
  end

  return plugin
end

local lspconfig = load_plugin('lspconfig')
local coq = load_plugin('coq')
local npairs = load_plugin('nvim-autopairs')

-- Auto Indent Pairs
npairs.setup({
  chars = { "{", "[", "(", "'", '"' },
  check_comma = true,
  check_ts = true,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
  },
})

local remap = vim.api.nvim_set_keymap
npairs.setup({ map_bs = false, map_cr = false })
vim.g.coq_settings = { keymap = { recommended = false } }

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

-- skip it, if you use another global object
_G.MUtils= {}

MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end
remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })

-- Global Diagnostic Mappings
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  -- GoTos
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  -- Inspection
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  -- Refactoring
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

-- Main Servers

local servers = {
  'rust_analyzer',
  'pyright',
  'dockerls',
  'html',
  'bashls',
  'jsonls',
  'terraformls',
  'cmake',
  'denols',
}

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

-- Use a loop to conveniently call 'setup' on multiple servers and map buffer local
-- keybindings when the language server attaches
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup(coq.lsp_ensure_capabilities({
    on_attach = on_attach,
    flags = { debounce_text_changes = 150 },
    settings = {
      ["rust_analyzer"] = {
        assist = {
          importGranularity = "module",
          importPrefix = "by_self",
        },
        cargo = {
          loadOutDirsFromCheck = true
        },
        procMacro = {
          enable = true
        }
      }
    }
  }))
end

-- ECMAScript

-- local eslint = {
--   lintCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT}',
--   lintIgnoreExitCode = true,
--   lintStdin = true,
--   lintFormats = { '%f:%l:%c: %m' },
--   formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}',
--   formatStdin = true,
-- }

-- local prettier = {
--   formatCommand = 'prettier --stdin-filepath ${INPUT}',
--   formatStdin = true,
-- }

-- local linters = {
--   eslint = {
--     sourceName = 'eslint',
--     command = 'eslint_d',
--     rootPatterns = {'.eslintrc.js', 'package.json' },
--     debounce = 100,
--     args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
--     parseJson = {
--       errorsRoot = '[0].messages',
--       line = 'line',
--       column = 'column',
--       endLine = 'endLine',
--       endColumn = 'endColumn',
--       message = '${message} [${ruleId}]',
--       security = 'severity',
--     },
--     securities = { [2] = 'error', [1] = 'warning', },
--   }
-- }

-- local formatters = {
--   prettier = { command = 'prettier', args = { '--stdin-filepath', '%filepath' }}
-- }

-- local formatFiletypes = { typescript = 'prettier', }

-- lspconfig.tsserver.setup {
--   on_attach = function(client)
--     client.resolved_capabilities.document_formatting = false
--     on_attach(client)
--   end
-- }
