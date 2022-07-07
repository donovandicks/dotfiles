set nocompatible
set autoindent
set expandtab
set incsearch
set noswapfile
set nu
set relativenumber
set shiftwidth=2
set smartindent
set softtabstop=2
set tabstop=2
set termguicolors
set signcolumn=yes

" Auto start COQ
let g:coq_settings = { 'auto_start': 'shut-up' }

" ===================LOAD PLUGINS==================== "
lua require('plugins')


" ==================LSP CONFIG======================== "
lua require('lsp_config.servers')
"lua require('rust-tools').setup({})


" ================TESTING CONFIG====================== "
lua require('testing')


" ===============TREESITTER CONFIG==================== "
lua require('tsitter')


" ===============TELESCOPE CONFIG===================== "
lua require('fuzzy_finder.tscope')


" ===============FORMATTING CONFIG==================== "
lua require('indent')
lua require('pairs')
lua require('formatting')

augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END


" ===================KEYMAPS========================== "
" Ctrl-[ to exit insert mode from :term emulation
tnoremap <C-[> <C-\><C-n>

" Formatting Keymaps
nnoremap <silent> <space>f :Format<CR>
nnoremap <silent> <space>F :FormatWrite<CR>

" lua <<EOF
"   local opts = { noremap=true, silent=true }
"   vim.keymap.set('n', '<space>t', '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', opts)
" EOF


" ===================COLORSCHEME====================== "
let g:gruvbox_contrast_dark='hard'
set background=dark
colorscheme gruvbox
autocmd FileType python set colorcolumn=88
highlight ColorColumn ctermbg=lightgrey
