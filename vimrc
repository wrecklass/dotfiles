" ~/.vimrc
" Wednesday, May 22, 2019 5:19 PM

" {{{ Section: Notes

" if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
" set filencodings=utf-8,latin1
" endif
"
" AUTOCOMPLETE
" :help |ins-completion|

" High-Lights:
" - ^x^n for JUST this file
" - ^x^f for Filenames (in subdirectories if turned on)
" - ^x^] for tags only
" - ^n for anything specified by the 'complete' option

" NOW We Can:
" - Use ^n and ^p to go back and forth in the suggestion list
"
" END AUTOCOMPLETE
" }}}
" {{{ Section: Bootstrap

set nocompatible
set pastetoggle=<F2>
set nobackup

filetype off
filetype plugin indent on
set rtp+=/usr/local/go/misc/vim
filetype on
set rtp+=/usr/local/opt/fzf

" Powerline Font
let g:airline_powerline_fonts = 1
let g:airline_theme='dark'

" ShellCheck: 
" let g:shellcheck_qf_open
" let g:shellcheck_ll_open

set background=dark

set encoding=utf8
set autoread
set switchbuf=usetab,newtab

" Use relative number, but show current line number
set number
set relativenumber

" viminfo reference:
" '20  : marks will be remembered to 20 previously edited files
" "100 : will saveup to 100 lines for each register
" :100  : up to 100 lines of command line history will be remembered
" %    : saves and restores buffer list
" n... : Name and location of viminfo file
set viminfo='20,\"100,:100,%,n~/.viminfo

" syntax on
syntax enable

packadd! matchit
" }}}
" {{{ Section: Moving around, searching, patterns and tags

" Set the cursor to different sizes for Insert, Replace and Normal mode
" Insert = | (Bar Cursor)
" Replace = _ (Underscore)

let &t_SI="\<Esc>[5 q"
let &t_SR="\<Esc>[3 q"
let &t_EI="\<Esc>[0 q"

set smartcase
set incsearch
set hlsearch
set ignorecase
set path=.,,

autocmd FileType c,cpp             setlocal path+=/usr/include include&
autocmd FileType sh,zsh,csh,tcsh   setlocal include=^\\s*\\%(\\.\\\|source\\)\\s
autocmd FileType dosbatch          setlocal include=^call | let &l:sua = tr($PATHEXT, ';', ',')
autocmd FileType sh,zsh,csh,tcsh,dosbatch let &l:path =
      \ tr($PATH, has('win32') ? ';' : ':', ',') . ',.'
autocmd FileType lua
      \ if expand('%:p') =~# '/awsome/' |
      \   let &l:path = expand('~/.config/awsome') . ',/etc/xdg/awsome,/usr/share/awsome/lib,' . &l:path |
      \ endif
autocmd FileType ruby setlocal tags=./tags;

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position
noremap <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
noremap <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>
" }}}
" {{{ Section: Displaying text

set display=lastline
set scrolloff=15
set sidescrolloff=5
set lazyredraw
set cmdheight=2
" }}}
" {{{ Section: Windows

set ruler
set laststatus=2
set showtabline=2

" When using airline, this doesn't matter
if empty(&g:statusline)
  "set statusline=%<%-40.50F\ %h%m%r=%-14.(%l/%L,%c%V%)\ %P
  set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
endif
set titlestring=%{v:progname}\ %{tolower(empty(v:servername)?'':'--servername\ '.v:servername.'\ ')}%{fnamemodify(getcwd(),':~')}%{exists('$SSH_TTY')?'\ <'.hostname().'>':''}
set iconstring=%{tolower(empty(v:servername)?v:progname\ :\ v:servername)}%{exists('$SSH_TTY')?'@'.hostname():''}

autocmd SourcePre */macros/less.vim set laststatus=0 showtabline=0

" From tpope C-j and C-k just toggle
nnoremap <C-j> <C-w>w
nnoremap <C-k> <C-w>W
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" switch window and maximize
" map <C-j> <C-W>j
" map <C-k> <C-W>k
" }}}
" {{{ Section: GUI

" Don't use GVim...
set mousemodel=popup
set mouse=a
" Allow the mouse to interact with tabs:
if has ("gui")
  set guifont=Consolas:h9:cANSI
endif

" }}}
" {{{ Section: Messages and Info

set novisualbell
set noerrorbells
set showcmd
set t_vb=
set tm=500
set t_Co=256
" }}}
" {{{ Section: Editing text and indent

" Tabs:
set tabstop=2
set shiftwidth=2
set expandtab

" Indenting:
set nocindent
set nosmartindent

set textwidth=0
" set colorcolumn=80
set cursorline
set backspace=2
set complete-=i         " Searching includes can be slow
set infercase
set showmatch
set virtualedit=block

set noshiftround
set nosmarttab
set noautoindent
set omnifunc=syntaxcomplete#Complete
set completefunc=syntaxcomplete#Complete

" }}}
" {{{ Section: Folding and Comments

if has('folding')
  set foldmethod=marker
  set foldopen+=jump
endif

autocmd FileType c,cpp,cs,java        setlocal commentstring=//\ %s
autocmd FileType desktop              setlocal commentstring=#\ %s
autocmd FileType sql                  setlocal commentstring=--\ %s
autocmd FileType xdefaults            setlocal commentstring=!%s
autocmd FileType json set sw=2 et

" Using vim-commentary for comment toggle

" }}}
" {{{ Section: Maps

" Set the map keys leader to comma:
let mapleader = ","
let g:mapleader = ","

set timeoutlen=2500
set ttimeoutlen=100
set updatetime=500

set tags+=.git/tags
nnoremap  <leader>ct  :!ctags -Rf .git/tags<CR><CR>

nmap     <C-n>        :NERDTreeToggle<CR>
nmap     <leader>n    :NERDTreeToggle<CR>
map      \|           :NERDTreeFind<CR>

cnoremap <C-a>        <Home>
cnoremap <C-b>        <Left>
cnoremap <C-f>        <Right>
cnoremap <C-d>        <Delete>
cnoremap <C-g>        <C-c>
cmap w!! w !sudo tee % >/dev/null

" avoid accidentally holding down shift while typing :w :q &c.
cabbrev  W   w
cabbrev  Q   q
cabbrev  Wq  wq

" Use Cap-Q for macros, to avoid accidentally starting them with q
" which gets annoying
noremap  Q   q
noremap  q   <Nop>

" Map jj to Escape easily
" Really helpful when in insert mode and start typing j to navigate
inoremap jj  <Esc>

inoremap <C-J>        <Down>
" inoremap <C-K><C-K>   <Up>

" Simple add closing block
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap " ""<Left>
" inoremap ' ''<Left>

" Remap Y to be consistent with C and D
map Y y$

" Source vimrc without restarting vim
" mnemonics Vimrc or Source
map      <leader>V           :source $MYVIMRC<CR>
map      <leader>S           :source $MYVIMRC<CR>

" Easy vertical split
nnoremap  <leader>v    :vs<CR>

nnoremap <leader>k  :m-2<CR>==
nnoremap <leader>j  :m+<CR>==

nnoremap  <leader>*  :s/\<<c-r><c-w>\>//g<Left><Left>

"  ,s to start a substitution
nnoremap <leader>s   :%s/

" typing ,w will write file
nnoremap <leader>w :w!<cr>

" typing ,q will write file and quit
nnoremap <leader>q :wq<cr>

" Toggle line numbers
nnoremap \l :setlocal number!<cr>
noremap <leader>l :setlocal relativenumber!<cr>

" Turn off hlsearch temporarily
nnoremap \q :nohlsearch<cr>
noremap <leader>h :nohlsearch<cr>

" Toggle case sensitive search
nnoremap <leader>i :setlocal ic!<cr>

" noremap j gj
" noremap k gk

" Use ,pp to toggle Paste mode
noremap <leader>pp :setlocal paste!<cr>
nnoremap \o :setlocal paste!<cr>

" ,m to erase all C-M's in a Dos file. Remembers location
noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"noremap <space> 8j
noremap <space> :call smooth_scroll#down(&scroll,25,1)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll,25,1)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll,25,1)<CR>
noremap <silent> <c-u> :call smooth_scroll#up(&scroll/2,25,1)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll/2,25,1)<CR>
" noremap <c-space> 8k

" noremap <leader>s ?(<CR>ldt,pldt)%p

" }}}
" {{{ Section: Reading and writing files

set fileformats=unix,dos
set backupskip+=/private/tmp/*

" }}}
" {{{ Section: Command line editing

set wildmenu
set history=200        " Keep 200 lines of command line history
set wildmode=full
set wildignore+=tags,.*.un~,*.pyc

" }}}
" {{{ Section: Filetype settings

autocmd FileType * setlocal nolinebreak
autocmd FileType xml,xsd,xslt,javascript setlocal ts=2
" }}}
" {{{ Section: AutoCmd

" Take from the Debian package and the example on $VIM/vim_examples
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

" Section: Function definitions

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  else
    return ''
  endif
endfunction

function! CmdLine(str)
  exe "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfunction

function! VisualSelection(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

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

set backupskip+=*.asc

augroup GPG
  autocmd!
  autocmd BufReadPost  *.asc :%!gpg -r stephen -q -d
  autocmd BufReadPost  *.asc |redraw!
  autocmd BufWritePre  *.asc :%!gpg -r stephen -q -e -a
  autocmd BufWritePost *.asc u
  autocmd VimLeave     *.asc :!clear
augroup END
" }}}

"vim: set et sw=2 foldmethod=marker
