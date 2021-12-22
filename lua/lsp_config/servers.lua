return function()
  local lspconfig = require('lspconfig')

  _G.lsp_organize_imports = function()
    local params = {
      command = '_typescript.organizeImports',
      arguments = { vim.api.nvim_buf_get_name(0) },
      title = '',
    }
    vim.lsp.buf.execute_command(params)
  end

  vim.cmd('command! LspOrganize lua lsp_organize_imports()')

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<Cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', 'gs', ':LspOrganize<CR>', opts)
  end

  local eslint = {
    lintCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT}',
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = { '%f:%l:%c: %m' },
    formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}',
    formatStdin = true,
  }

  local prettier = {
    formatCommand = 'prettier --stdin-filepath ${INPUT}',
    formatStdin = true,
  }

  local filetypes = { typescript = 'eslint', }

  local linters = {
    eslint = {
      sourceName = 'eslint',
      command = 'eslint_d',
      rootPatterns = {'.eslintrc.js', 'package.json' },
      debounce = 100,
      args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
      parseJson = {
        errorsRoot = '[0].messages',
        line = 'line',
        column = 'column',
        endLine = 'endLine',
        endColumn = 'endColumn',
        message = '${message} [${ruleId}]',
        security = 'severity',
      },
      securities = { [2] = 'error', [1] = 'warning', },
    }
  }

  local formatters = {
    prettier = { command = 'prettier', args = { '--stdin-filepath', '%filepath' }}
  }
  
  local formatFiletypes = { typescript = 'prettier', }

  local servers = {
    'rust_analyzer',
    'pyright',
    'dockerls',
    'html',
    'bashls',
    'jsonls',
    'svelte',
  }

  local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Use a loop to conveniently call 'setup' on multiple servers and map buffer local
  -- keybindings when the language server attaches
  for _, lsp in pairs(servers) do
    lspconfig[lsp].setup({
      on_attach = on_attach,
      init_options = { documentFormatting = false, },
      flags = { debounce_text_changes = 150 },
      capabilities = capabilities
    })
  end

  lspconfig.diagnosticls.setup {
    on_attach = on_attach,
    filetypes = vim.tbl_keys(filetypes),
    init_options = {
      filetypes = filetypes,
      linters = linters,
      formatters = formatters,
      formatFiletypes = formatFiletypes,
    }
  }

  lspconfig.tsserver.setup {
    on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
      on_attach(client)
    end
  }
end
