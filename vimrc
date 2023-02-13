" Author: Stephen Martin
" Date: 10/25/21 01:44:17
" {{{ Settings

" Force fzf.vim to work on Cygwin. Might need to unset for Unix systems.
let $TERM="cygwin"
" Because file permissions don't matter much to us:
set autoread
" Start this way, turn on once plugins are loaded
filetype off

set wildmode=longest,list,full
" let g:ale_completion_enabled = 1
" set omnifunc=ale#completion#OmniFunc
"
let g:ft_man_open_mode='tab'

set wildmenu
"Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

if has('folding')
  set foldmethod=marker
  set foldopen+=jump
  set foldcolumn=1
endif

" nvim is supposed to be nocompatible by default
set nocompatible
set exrc
set relativenumber
set number

" Searching
set hlsearch
set smartcase
set incsearch
set ignorecase

" Show matching parens
set showmatch

" use this number of 1/10ths of seconds to show match
set matchtime=5


" Keep from searching outside of current dir
set path=.,,

" No bells
set novisualbell
set noerrorbells

set showcmd
set t_vb=
set timeoutlen=1000
set ttimeoutlen=100
set updatetime=500

set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set nosmartindent
set wrap
set textwidth=0

set matchpairs+=<:>

" Highlight the cursor line on display
set cursorline

" Where the backspace key works
set backspace=eol,start,indent

" Move over EOL when moving cursor
set whichwrap+=<,>,h,l

" Searching includes can be slow, so we don't
set complete-=i

" Command line matching can infer case
set infercase

" Don't like leaving swapfiles around
set noswapfile

" No backup file created
set nobackup

" Where to store undo history
set undodir=/home/smartin/.vim/undodir
set undofile

" Don't default to Read Only in vimdiff
set noro

set termguicolors
set showmode
set completeopt=menuone,noinsert,noselect
set signcolumn=yes
set colorcolumn=80

set pastetoggle=<F2>

" Give more space for displaying messages.
set cmdheight=2
set display=lastline

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=8
set sidescrolloff=5
set lazyredraw

"	Show the line and column number of the cursor position
set ruler

" Always show statusline
set laststatus=2

" Always show tabline
set showtabline=2

"	Round indent to multiple of 'shiftwidth'.  Applies to > and <
set noshiftround

" Insert tabs according to Shiftwidth
set nosmarttab

" Don't do it!
set noautoindent

" Autocomplete with ^X^O
set omnifunc=syntaxcomplete#Complete
set completefunc=syntaxcomplete#Complete

" Having longer updatetime (default is 4000ms = 4 s) leads to
" noticeable delays and poor user experience
set updatetime=50

" Optimize for fast terminal connections
set ttyfast

" Don't use GVim...
set t_Co=256
set mousemodel=popup
set mouse=a
" Allow the mouse to interact with tabs:
if has ("gui")
    " set guifont=Consolas:h14
    " set guifont=Droid\ Sans\ Mono\ Dotted\ for\ Powerline:h13
    set guifont=FiraCode\ NF:h12
endif


" Don't pass messages to |ins-completion-menu|.
" set shortmess+=c
"
" }}}
" {{{ Plugins
call plug#begin('~/.vim/plugged')

" Plug 'dense-analysis/ale'
Plug 'mattn/emmet-vim'
Plug 'vim-utils/vim-man'
Plug 'airblade/vim-gitgutter'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', {'do' : { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'vuciv/vim-bujo'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-projectionist'
Plug 'scrooloose/nerdtree'
Plug 'BurntSushi/ripgrep'
Plug 'octol/vim-cpp-enhanced-highlight'
" Go complete, quite old
Plug 'fisadev/vim-sane-gocomplete'

Plug 'terryma/vim-smooth-scroll'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'ap/vim-css-color'

Plug 'mhinz/vim-rfc'
Plug 'frazrepo/vim-rainbow'

" Plug 'puremourning/vimspector'

" Ok, colorschemes:
Plug 'gruvbox-community/gruvbox'
" Plug 'sainnhe/gruvbox-material'
call plug#end()
" }}}
" {{{ Color Scheme
let g:gruvbox_italic=1
" colorscheme gruvbox-material
colorscheme gruvbox
highlight Normal guibg=background
hi QuickFixLine guibg=#65000B ctermbg=darkred

" Airline Status Bar
let g:airline_powerline_fonts=1

" let g:airline_theme='ayu_dark'
" let g:airline_theme='cool'
" let g:airline_theme='dark'
" let g:airline_theme='deus'
" let g:airline_theme='google_dark'
" let g:airline_theme='luna'
" let g:airline_theme='molokai'
" let g:airline_theme='monochrome'
" let g:airline_theme='night_owl'
" let g:airline_theme='papercolor'
" let g:airline_theme='raven'
" let g:airline_theme='term'
" let g:airline_theme='selenized_bw'
" let g:airline_theme='tomorrow'
" let g:airline_theme='understated'
" let g:airline_theme='ravenpower'
" let g:airline_theme='murmur'
" let g:airline_theme='badwolf'
" let g:airline_theme='base16'
" let g:airline_theme='base16_ashes'
" let g:airline_theme='base16_bright'
" let g:airline_theme='base16_black_metal'
" let g:airline_theme='base16_classic'
" let g:airline_theme='base16_colors'
" let g:airline_theme='base16_chalk'
" let g:airline_theme='base16_classic_dark'
" let g:airline_theme='base16_darktooth'
" let g:airline_theme='base16_decaf'
" let g:airline_theme='base16_default_dark'
" let g:airline_theme='base16_eighties'
" let g:airline_theme='base16_embers'
" let g:airline_theme='base16_espresso'
" let g:airline_theme='base16_flat'
" let g:airline_theme='base16_framer'
" let g:airline_theme='base16_gigavolt'
" let g:airline_theme='base16_google'
" let g:airline_theme='base16_grayscale'
" let g:airline_theme='base16_gruvbox_dark_soft'
" let g:airline_theme='base16_gruvbox_dark_medium'
let g:airline_theme='base16_gruvbox_dark_hard'
" let g:airline_theme='base16_helios'
" let g:airline_theme='base16_materia'
" let g:airline_theme='base16_material'
" let g:airline_theme='base16_material_darker'
" let g:airline_theme='base16_phd'
" let g:airline_theme='base16_sandcastle'
" let g:airline_theme='base16_snazzy'
" let g:airline_theme='base16_tomorrow'
" let g:airline_theme='base16_tube'
" let g:airline_theme='base16color'
" let g:airline_theme='base16_vim'
" let g:airline_theme='base16_unikitty_dark'
" let g:airline_theme='base16_synth_midnight_dark'
" let g:airline_theme='base16_summerfruit_dark'
" let g:airline_theme='base16_snazzy'
" let g:airline_theme='base16_shell'
" let g:airline_theme='base16_porple'
" let g:airline_theme='base16_outrun_dark'
" let g:airline_theme='base16_londontube'
" let g:airline_theme='base16_irblack'
" color00 = Background
try
  let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.dark': {
  \       'override' : {
  \         'color00'       : ['#080808', '232'],
  \         'cursorline'    : ['#444444', '238'],
  \         'linenumber_fg' : ['#767676', '243'],
  \         'linenumber_bg' : ['#080808', '232'],
  \         'folded_bg'     : ['#6c6c6c', '242'],
  \         'folded_fg'     : ['#262626', '235'],
  \       }
  \     }
  \   }
  \ }

  " colorscheme PaperColor
catch
endtry

" We want dark anyway
set background=dark
" }}}
" {{{ Mappings

let mapleader = " "
let g:mapleader = " "

nnoremap <leader><     :cprev<CR>
nnoremap <leader>>     :cnext<CR>
nnoremap <leader>S      :source $MYVIMRC<CR>
nnoremap <leader>V      :so $MYVIMRC<CR>
nnoremap <leader><CR>   :so $MYVIMRC<CR>
nnoremap <leader>w      :w<CR>

" typing leader z will write file and quit, like ZZ
nnoremap <leader>z          :wq<CR>
" Or exit without saving changes
nnoremap <leader>Q          :q!<CR>

nnoremap <leader>vh  :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>bs  /<C-R>=escape(expand("<cword>"), "/")<CR><CR>
nnoremap <leader>u   :UndotreeShow<CR>
nnoremap <leader>pv  :Ex<CR>
nnoremap <leader>+   :resize +5<CR>
nnoremap <leader>=   :resize +5<CR>
nnoremap <leader>-   :resize -5<CR>
nnoremap <leader>rp  :resize 100<CR>
" nnoremap <leader>ee  oif err != nil {<CR>log.Fatalf("%+v\n", err)<CR>}<CR><esc>kkI<esc>
nnoremap <leader>cpu a%" PRIu64 "<esc>
nnoremap <leader>s   :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
nnoremap <leader>gt  <Plug>PlenaryTestFile
nnoremap <leader>gll :let g:_search_term = expand("%")<CR><bar>:Gclog -- %<CR>:call search(g:_search_term)<CR>
nnoremap <leader>gln :cnext<CR>:call search(_search_term)<CR>
nnoremap <leader>glp :cprev<CR>:call search(_search_term)<CR>

" Easy vertical split
nnoremap  <leader>v    :vs<CR>
nnoremap  <leader>H    :sp<CR>

" end highlighting by searching for garbage
nnoremap  <leader>;    /xckla<CR>

nnoremap <leader>j  :m+<CR>==
nnoremap <leader>k  :m-2<CR>==

" Toggle line numbers
nnoremap \l :setlocal number!<CR>
noremap <leader>l :setlocal relativenumber!<CR>

" Turn off hlsearch temporarily
nnoremap \q :set hlsearch!<CR>
noremap <leader>h :set hlsearch!<CR>

" Globally search and replace the <word> under the cursor
nnoremap  <leader>*  :%s/\<<c-r><c-w>\>//g<Left><Left>

"  <Leader>s to start a substitution
nnoremap <leader>s   :%s/

" Toggle case sensitive search
nnoremap <leader>i :setlocal ic!<CR> :setlocal ic?<CR>

" Show list of buffers and then prompt for which to switch to
nnoremap <F5> :buffers<CR>:buffer<Space>


" <leader>m to erase all ^M in a Dos file. Remembers location
noremap <leader>m mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fast editing and reloading of vimrc configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>e :e! $MYVIMRC<cr>
autocmd! BufWritePost $MYVIMRC source $MYVIMRC

" Use ,pp to toggle Paste mode
noremap <leader>pp :setlocal paste!<CR>
nnoremap \o :setlocal paste!<CR>

" Swap lines in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<+1<CR>gv=gv

nnoremap <c-j>  <C-W>w
nnoremap <c-k>  <C-W>W
nnoremap <c-h>  <C-W>h
nnoremap <c-l>  <C-W>l

"noremap <space> 8j
" Smooth movements
" noremap <silent> <space> :call smooth_scroll#down(&scroll,20,1)<CR>
noremap <silent> <c-b>   :call smooth_scroll#up(&scroll,20,1)<CR>
noremap <silent> <c-f>   :call smooth_scroll#down(&scroll,20,1)<CR>
noremap <silent> <c-u>   :call smooth_scroll#up(&scroll/2,20,1)<CR>
noremap <silent> <c-d>   :call smooth_scroll#down(&scroll/2,20,1)<CR>
" noremap <c-space> 8k

" Remap Y to be consistent with C and D
nnoremap Y yg$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Make b movement inclusive
onoremap b vb

" greatest remap ever
xnoremap <leader>p "_dP
nnoremap <leader>p "+

" Paste in system clipboard with ^P
inoremap <expr> <c-p> pumvisible() ? '<c-p>' : '<c-r>+'

" next greatest remap ever
" Yank to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+y$
xnoremap <leader>y "+y
" Copy everything to clipboard
" nnoremap <c-y> mqgg"+yG'q
" nnoremap <c-y> <cmd>%y +<CR>

nnoremap <leader>d "_d

" nnoremap <Leader>ww ofunction wait(ms: number): Promise<void> {<CR>return new Promise(res => setTimeout(res, ms));<CR>}<esc>k=i{<CR>

" Cause, of course
inoremap <C-c> <esc>

nmap     <leader>nt   <c-w>T
nmap     <C-n>        :NERDTreeToggle<CR>
nmap     <leader>n    :NERDTreeToggle<CR>
map      \|           :NERDTreeFind<CR>

map      <leader>E    :Explore<CR>

cnoremap <C-a>        <Home>
cnoremap <C-b>        <Left>
cnoremap <C-f>        <Right>
" cnoremap <C-d>        <Delete>
" cnoremap <C-g>        <C-c>
cmap w!! w !sudo tee % >/dev/null

" avoid accidentally holding down shift while typing :w :q &c.
cabbrev  W   w
cabbrev  Q   q
cabbrev  Wq  wq

" Use Cap-Q for macros, to avoid accidentally starting them with q
" which gets annoying
noremap  Q   q
noremap  q   <Nop>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General abbreviations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab ddate <c-r>=strftime("%m/%d/%y %H:%M:%S")<cr>

" Map jj to Escape easily
" Really helpful when in insert mode and start typing j to navigate
" inoremap jj  <Esc>

inoremap <C-J>        <Down>
" inoremap <C-K><C-K>   <Up>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Pressing <leader>r sets up search and replace on visual selection
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Open vimgrep and put the cursor in the right position
noremap <leader>g :vimgrep // **/*<left><left><left><left><left><left>

" Vimgreps in the current file
noremap <leader><space> :vimgrep // <C-R>%<HOME><right><right><right><right><right><right><right><right><right>
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
" {{{ visualselection
function! CmdLine(str)
  call feedkeys(":" . a:str)
  " Old way
  " exe "menu Foo.Bar :" . a:str
  " emenu Foo.Bar
  " unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", "\\/.*'$^~[]")
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("Ag " . l:pattern )
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

" }}}
" {{{ Bclose function

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")

  if buflisted(l:alternateBufNum)
    buffer #
  else
    bnext
  endif

  if bufnr("%") == l:currentBufNum
    new
  endif

  if buflisted(l:currentBufNum)
    execute("bdelete! ".l:currentBufNum)
  endif
endfunction

" }}}
" {{{ Autocmd move to last position on openfile
if has("autocmd")

    filetype plugin indent on
    " Move to the last position ('") when this file was opened
    autocmd BufReadPost *
            \  if line("'\"") > 0 && line("'\"") <= line("$") |
            \    exe "normal! g'\"" |
            \  endif

    " set viminfo^=%
    set viminfo='20,\"100,:100,%,n~/.viminfo
    packadd! matchit

    " ********* Don't like tw != 0 *********
    " au FileType text set tw=78
    " Colorful brackets/parens
    let g:rainbow_active = 1
    autocmd FileType c,cpp             setlocal path+=/usr/include include&
    autocmd FileType sh,zsh,csh,tcsh   setlocal include=^\\s*\\%(\\.\\\|source\\)\\s
    autocmd FileType dosbatch          setlocal include=^call | let &l:sua = tr($PATHEXT, ';', ',')
    autocmd FileType json set sw=2 et

    autocmd FileType sh,zsh,csh,tcsh,dosbatch let &l:path =
          \ tr($PATH, has('win32') ? ';' : ':', ',') . ',.'

    autocmd FileType lua
          \ if expand('%:p') =~# '/awsome/' |
          \   let &l:path = expand('~/.config/awsome') . ',/etc/xdg/awsome,/usr/share/awsome/lib,' . &l:path |
          \ endif

    autocmd FileType ruby setlocal tags=./tags;

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
