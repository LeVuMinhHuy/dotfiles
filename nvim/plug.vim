if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

if has("nvim")
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'onsails/lspkind-nvim'
	Plug 'L3MON4D3/LuaSnip'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'hoob3rt/lualine.nvim'
  Plug 'ggandor/lightspeed.nvim'
	Plug 'jiangmiao/auto-pairs'
	Plug 'preservim/nerdtree'
	Plug 'ryanoasis/vim-devicons'
	Plug 'eugen0329/vim-esearch'
	Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
  Plug 'jparise/vim-graphql'
  Plug 'rust-lang/rust.vim'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
  Plug 'akinsho/git-conflict.nvim' 
  Plug 'tamton-aquib/duck.nvim'
endif

call plug#end()
