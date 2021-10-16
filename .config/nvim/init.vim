" General stuff
set guicursor=
set termguicolors
set noerrorbells
set relativenumber
set number
set scrolloff=8
set colorcolumn=80,100
set signcolumn=yes
set hidden
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" Search stuff
set nohlsearch
set incsearch
set ignorecase
set smartcase

" Tabs
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Set this if you want to source a vimrc within a working directory
set exrc

call plug#begin('~/.vim/plugged')

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'

Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

" Nice completion for pairs, quotes etc
Plug 'jiangmiao/auto-pairs'

" Colorscheme
Plug 'gruvbox-community/gruvbox'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'joshdick/onedark.vim'

call plug#end()

set background=dark
let g:material_theme_style='palenight'
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_italic=1
let g:gruvbox_italicize_comments=1
let g:gruvbox_italicize_strings=0
let g:gruvbox_bold=0
colorscheme gruvbox


" Activate syntax highlighting -> (:TSInstall <language>)
lua << EOF
require'nvim-treesitter.configs'.setup {
  indent = { enable = true },
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true }
}
EOF

set completeopt=menu,menuone,noselect

" Setup each installed lsp
lua << EOF
  require("lspinstall").setup()

  -- Setup autocompletion
  local cmp = require'cmp'
  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
      ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
    }
  })

  -- Lsp server and link autocompletion
  local servers = require'lspinstall'.installed_servers()
  local capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  )
  for _, server in pairs(servers) do
    require'lspconfig'[server].setup {
      capabilities = capabilities,
    }
  end

  -- Telescope setup
  require('telescope').setup {
    defaults = {
      file_sorter = require('telescope.sorters').get_fzy_sorter,
      prompt_prefix = '->',
      color_devicons = true,

      file_previewer = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      }
    }
  }
  require('telescope').load_extension('fzy_native')
EOF

let mapleader=' '
nnoremap <leader>\t :wincmd s<bar> :resize 10<bar> :term<CR>
nnoremap <leader>\\ :wincmd v<CR>

nnoremap <leader>ps :lua require("telescope.builtin").grep_string({ search = vim.fn.input("Grep for->")})<CR>
nnoremap <C-p> :lua require("telescope.builtin").git_files()<CR>
nnoremap <leader>pb :lua require("telescope.builtin").buffers()<CR>

nnoremap <leader>vd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>vrn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>


