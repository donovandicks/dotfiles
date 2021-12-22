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

" ===================START PLUGINS==================== "
call plug#begin('~/AppData/Local/nvim/plugged')
" Nvim tools, common dependencies
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'

" Fuzzy finding
Plug 'nvim-telescope/telescope.nvim'

" Language Support
Plug 'nvim-treesitter/nvim-treesitter', { 'do': 'TSUpdate' }
Plug 'nvim-treesitter/playground'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'neovim/nvim-lspconfig'

" Completions
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'

" Snippets
Plug 'rafamadriz/friendly-snippets'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Git
Plug 'tpope/vim-fugitive'

" Keyboard QOL
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" Formatting
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'windwp/nvim-autopairs'

" Themes
Plug 'rktjmp/lush.nvim'
Plug 'npxbr/gruvbox.nvim'
call plug#end()


" ===================COLORSCHEME====================== "
let g:gruvbox_contrast_dark='hard'
set background=dark
colorscheme gruvbox
set colorcolumn=100
highlight ColorColumn ctermbg=lightgrey


" ===================KEYMAPS========================== "
" Ctrl-[ to exit insert mode from :term emulation
tnoremap <C-[> <C-\><C-n>


" ==================LSP CONFIG======================== "
lua require('lsp_config.servers')()


" ==================DOGECONFIG======================== "
let g:doge_mapping = '<space>d' 


" ===============TREESITTER CONFIG==================== "
lua require('tree.treesitter')()


" ===============TELESCOPE CONFIG===================== "
lua require('fuzzy_finder.telescope')()


" ===============FORMATTING CONFIG==================== "
lua require('indent')() 
lua require('pairs')()


" ==================COMPLETION CONFIG====================== "
" set completeopt=menuone,noselect
lua require('lsp_config.completions')()


" ===================SNIP CONFIG====================== "
lua require('snippets')()

