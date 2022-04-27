" VIMRC for NVIM
" {{{ Sets
" Do we want these?
" set guicursor=
" set path+=**

set wildmode=longest,list,full
set wildmenu

"Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

set foldmethod=marker

" nvim is supposed to be nocompatible by default
" set nocompatible
set exrc
set relativenumber
set hlsearch
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set wrap
set smartcase
set ignorecase
set noswapfile
set nobackup
set undodir=C:\Users\smartin\.vim\undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set showmode
set completeopt=menuone,noinsert,noselect
set signcolumn=yes
set colorcolumn=80

set pastetoggle=<F2>

set t_Co=256
set mousemodel=popup
set mouse=a

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000ms = 4 s) leads to
" noticeable delays and poor user experience
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
" set shortmess+=c
" }}}
" {{{ Plugins
call plug#begin('~/.vim/plugged')

" Plebvim lsp Plugins
" Plug 'neovim/nvim-lspconfig'

" Neovim Tree shitter
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'nvim-treesitter/playground'

" Plug 'sharkdp/fd'

" Plug 'neoclide/coc.nvim'

" Plug 'hrsh7th/cmp-nvim-lsp'

Plug 'mattn/emmet-vim'
Plug 'vim-utils/vim-man'
Plug 'airblade/vim-gitgutter'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do' : { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'vuciv/vim-bujo'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'junegunn/gv.vim'
Plug 'scrooloose/nerdtree'
Plug 'theprimeagen/vim-be-good'
Plug 'BurntSushi/ripgrep'
Plug 'gruvbox-community/gruvbox'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tpope/vim-projectionist'

" Telescope requirements:
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'sainnhe/gruvbox-material'
Plug 'vim-conf-live/vimconflive2021-colorscheme'
Plug 'ap/vim-css-color'

call plug#end()
" }}}
" {{{ GUI
" Much better than the Bright lights of plain gruvbox...
" colorscheme vimconflive-2021
" colorscheme gruvbox
colorscheme gruvbox-material
highlight Normal guibg=background

if has ("gui")
    set guifont=FiraCode\ NF:h12,Consolas
endif
let g:airline_powerline_fonts = 1
let g:airline_theme='ayu_dark'
" }}}
" {{{ Mappings
" mode lhs rhs
let   mapleader = " "
" let g:mapleader = " "

nnoremap <silent> Q <nop>

nnoremap <leader>V    :so $MYVIMRC<CR>
nnoremap <leader><CR> :so $MYVIMRC<CR>
nnoremap <leader>w    :w<CR>

" typing ,q will write file and quit
nnoremap <leader>q :wq<CR>
nnoremap <leader>Q :q!<CR>

nnoremap <leader>px :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ") })<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>

nnoremap <leader>vwh :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>bs  /<C-R>=escape(expand("<cword>"), "/")<CR><CR>
nnoremap <leader>u   :UndotreeShow<CR>
nnoremap <leader>pv  :Ex<CR>
nnoremap <leader>+   :resize +5<CR>
nnoremap <leader>=   :resize +5<CR>
nnoremap <leader>-   :resize -5<CR>
nnoremap <leader>rp  :resize 100<CR>
nnoremap <leader>ee  oif err != nil {<CR>log.Fatalf("%+v\n", err)<CR>}<CR><esc>kkI<esc>
nnoremap <leader>cpu a%" PRIu64 "<esc>
nnoremap <leader>s   :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
nnoremap <leader>gt  <Plug>PlenaryTestFile
nnoremap <leader>gll :let g:_search_term = expand("%")<CR><bar>:Gclog -- %<CR>:call search(g:_search_term)<CR>
nnoremap <leader>gln :cnext<CR>:call search(_search_term)<CR>
nnoremap <leader>glp :cprev<CR>:call search(_search_term)<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fast editing and reloading of vimrc configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>e :e! $MYVIMRC<cr>
autocmd! BufWritePost $MYVIMRC source $MYVIMRC

" Use ,pp to toggle Paste mode
noremap <leader>pp :setlocal paste!<CR>
nnoremap \o :setlocal paste!<CR>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<+1<CR>gv=gv

" vertical split
nnoremap <leader>v  :vs<CR>
" horizontal split
nnoremap <leader>H  :sp<CR>

" Turn on and off spell checking for current file
nnoremap         <leader>sp   :setlocal spell spelllang=en_us<CR>
nnoremap         <leader>ps   :setlocal nospell<CR>

nnoremap <c-j>  <C-W>w
nnoremap <c-k>  <C-W>W
nnoremap <c-h>  <C-W>h
nnoremap <c-l>  <C-W>l

nnoremap Y yg$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" greatest remap ever
xnoremap <leader>p "_dP

" next greatest remap ever
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

nnoremap <leader>d "_d
nnoremap <leader>d "_d

nnoremap <Leader>ww ofunction wait(ms: number): Promise<void> {<CR>return new Promise(res => setTimeout(res, ms));<CR>}<esc>k=i{<CR>

" Cause, of course
inoremap <C-c> <esc>

map <silent> <leader>V :source $MYVIMRC<CR>
map <silent> <leader>S :source $MYVIMRC<CR>
nmap <C-n>     :NERDTreeToggle<CR>
" }}}
" {{{ Status line
" When using airline, this doesn't matter
if empty(&g:statusline)
  "set statusline=%<%-40.50F\ %h%m%r=%-14.(%l/%L,%c%V%)\ %P
  set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
endif

set titlestring=%{v:progname}\ %{tolower(empty(v:servername)?'':'--servername\ '.v:servername.'\ ')}%{fnamemodify(getcwd(),':~')}%{exists('$SSH_TTY')?'\ <'.hostname().'>':''}
set iconstring=%{tolower(empty(v:servername)?v:progname\ :\ v:servername)}%{exists('$SSH_TTY')?'@'.hostname():''}lightlight

autocmd SourcePre */macros/less.vim set laststatus=0 showtabline=0

function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  else
    return ''
  endif
endfunction
" }}}
" {{{ Empty Registers (Marks)
fun! EmptyRegisters()
    let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890/-"', '\zs')
    for r in regs
        call setreg(r,[])
    endfor
endfun
" }}}
" {{{ Misc
" so :W is the same as :w
com! W w

nmap <leader>nn  :echo "hi<" . synIDattr(synID("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") .">"<CR>
" }}}
" {{{ Trim all trailing whitespaces on save
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup TWS
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END
" }}}
" {{{ Autocmd move to last position on openfile
if has("autocmd")

  " filetype plugin indent on

  au BufReadPost *
        \  if line("'\"") > 0 && line("'\"") <= line("$") |
        \    exe "normal! g'\"" |
        \  endif

  set viminfo^=%

  " ********* Don't like tw != 0 *********
  " au FileType text set tw=78

  " Set some sensible defaults for editing C-files
  " augroup cprog
  " Remove all cprog autocommands
  " au!

  " When starting to edit a file:
  "   For *.c and *.h files set formatting of comments and set C-indenting on.
  "   For other files switch it off.
  "   Don't change the order, it's important that the line with * comes first.
  " autocmd BufRead *       set formatoptions=tcql nocindent comments&
  " autocmd BufRead *.c,*.h set formatoptions=croql nocindent comments=sr:/*,mb:*,el:*/,://
  " augroup END

else
  set autoindent
endif " has ("autocmd")
" }}}
