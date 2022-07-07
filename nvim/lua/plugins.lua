return require('packer').startup(function()
  use {
    -- Packer
    'wbthomason/packer.nvim',

    -- Tools & Common dependencies
    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim',
    'mfussenegger/nvim-dap',

    -- Language Support
    { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
    'neovim/nvim-lspconfig',

    -- Completions
    { 'ms-jpq/coq_nvim', branch = 'coq' },

    -- Testing
    {
      "nvim-neotest/neotest",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim"
      }
    },

    {
      "nvim-neotest/neotest-python",
      requires = { "nvim-neotest/neotest" }
    },

    -- FZF
    'nvim-telescope/telescope.nvim',

    -- Git
    'tpope/vim-fugitive',

    -- Keyboard Shortcuts
    'tpope/vim-surround',
    'tpope/vim-commentary',

    -- Formatting
    'lukas-reineke/indent-blankline.nvim',
    'windwp/nvim-autopairs',
    'mhartington/formatter.nvim',

    -- Colorscheme
    'rktjmp/lush.nvim',
    'ellisonleao/gruvbox.nvim',
  }
end)
