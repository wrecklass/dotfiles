" ~/.vimrc
" Wednesday, May 22, 2019 5:19 PM

" Section: Notes {{{

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
" Section: Bootstrap {{{

set nocompatible
set pastetoggle=<F2>
set nobackup
set nowritebackup
set dir=/tmp,/var/tmp,~/tmp

set langmenu=en
let LANG='en_US.UTF-8'
" Reset menus
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Hide buffers that are abandoned
set hid

" Turn on magic for Regular Expressions
set magic

" Temporary work around, needed to get 'gx' to work
" Also added vim/plugin/netrwPlugin.vim with minor change
" Probably won't work with Windows or Linux
let g:netrw_browsex_viewer="open"

filetype off
filetype plugin indent on
set rtp+=/usr/local/go/misc/vim
set rtp+=/usr/local/opt/fzf
" FZF is so confusing
" set rtp+=~/.vim/pack/junegunn/start/fzf/autoload/fzf
" source   ~/.vim/pack/junegunn/start/fzf/autoload/fzf/vim.vim
" source   ~/.vim/pack/junegunn/start/fzf/autoload/fzf/vim/complete.vim
filetype on

" Powerline Font
let g:airline_powerline_fonts = 1
let g:airline_theme='papercolor'

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

if v:version > 800
  packadd! matchit
endif
" }}}
" Section: Moving around, searching, patterns and tags {{{

" Set the cursor to different sizes for Insert, Replace and Normal mode
" Insert = | (Bar Cursor)
" Replace = _ (Underscore)

let &t_SI="\<Esc>[5 q"
let &t_EI="\<Esc>[0 q"

if v:version > 800
  let &t_SR="\<Esc>[3 q"
endif

set smartcase
set incsearch
set hlsearch
set ignorecase
" Keep from searching outside of current dir
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

" }}}
" Section: Displaying text {{{

set display=lastline
set scrolloff=15
set sidescrolloff=5
set lazyredraw
set cmdheight=2
" }}}
" Section: Windows {{{

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
" Section: GUI {{{

" Don't use GVim...
set t_Co=256
set mousemodel=popup
set mouse=a
" Allow the mouse to interact with tabs:
if has ("gui")
  " set guifont=Consolas:h14
  set guifont=Droid\ Sans\ Mono\ Dotted\ for\ Powerline:h13
endif

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

  colorscheme PaperColor
catch
endtry

" }}}
" Section: Messages and Info {{{

set novisualbell
set noerrorbells
set showcmd
set t_vb=
set tm=500
" }}}
" Section: Editing text and indent {{{

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
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set complete-=i         " Searching includes can be slow
set infercase

" Show matching parens
set showmatch
" use this number of 1/10ths of seconds to show match
set mat=5

set virtualedit=block

set noshiftround
set nosmarttab
set noautoindent
set omnifunc=syntaxcomplete#Complete
set completefunc=syntaxcomplete#Complete

" }}}
" Section: Folding and Comments {{{

if has('folding')
  set foldmethod=marker
  set foldopen+=jump
  set foldcolumn=1
endif

autocmd FileType c,cpp,cs,java        setlocal commentstring=//\ %s
autocmd FileType desktop              setlocal commentstring=#\ %s
autocmd FileType sql                  setlocal commentstring=--\ %s
autocmd FileType xdefaults            setlocal commentstring=!%s
autocmd FileType json set sw=2 et

" Using vim-commentary for comment toggle

" }}}
" Section: Maps {{{

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

map      -            :Explore<CR>

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
" inoremap jj  <Esc>

inoremap <C-J>        <Down>
" inoremap <C-K><C-K>   <Up>

" Nice as this sounds, it gets in the way too often
" Simple add closing block
" inoremap ( ()<Left>
" inoremap [ []<Left>
" inoremap { {}<Left>
" inoremap " ""<Left>
" inoremap ' ''<Left>

" Remap Y to be consistent with C and D
map Y y$

" Source vimrc without restarting vim
" mnemonics Vimrc or Source
map    <silent>  <leader>V    :source $MYVIMRC<CR>
map    <silent>  <leader>S    :source $MYVIMRC<CR>

" Easy vertical split
nnoremap  <leader>v    :vs<CR>

nnoremap  <leader>H    :sp<CR>

nnoremap <leader>j  :m+<CR>==
nnoremap <leader>k  :m-2<CR>==

" Globally search and replace the <word> under the cursor
nnoremap  <leader>*  :%s/\<<c-r><c-w>\>//g<Left><Left>

"  ,s to start a substitution
nnoremap <leader>s   :%s/

" typing ,w will write file
nnoremap <leader>w :w!<CR>

" typing ,q will write file and quit
nnoremap <leader>q :wq<CR>
nnoremap <leader>Q :q!<CR>
nnoremap <leader>Z :wq!<CR>

" Toggle line numbers
nnoremap \l :setlocal number!<CR>
noremap <leader>l :setlocal relativenumber!<CR>

" Turn off hlsearch temporarily
nnoremap \q :nohlsearch<CR>
noremap <leader>h :nohlsearch<CR>

" Toggle case sensitive search
nnoremap <leader>i :setlocal ic!<CR> :setlocal ic?<CR>

" Use ,pp to toggle Paste mode
noremap <leader>pp :setlocal paste!<CR>
nnoremap \o :setlocal paste!<CR>

" ,m to erase all ^M in a Dos file. Remembers location
noremap <leader>m mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm

"noremap <space> 8j
noremap <silent> <space> :call smooth_scroll#down(&scroll,20,1)<CR>
noremap <silent> <c-b>   :call smooth_scroll#up(&scroll,20,1)<CR>
noremap <silent> <c-f>   :call smooth_scroll#down(&scroll,20,1)<CR>
noremap <silent> <c-u>   :call smooth_scroll#up(&scroll/2,20,1)<CR>
noremap <silent> <c-d>   :call smooth_scroll#down(&scroll/2,20,1)<CR>
" noremap <c-space> 8k

" noremap <leader>s ?(<CR>ldt,pldt)%p

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
" inoremap $1 ()<esc>i
" inoremap $2 []<esc>i
" inoremap $3 {}<esc>i
" inoremap $4 {<esc>o}<esc>O
" inoremap $q ''<esc>i
" inoremap $e ""<esc>i

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General abbreviations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab ddate <c-r>=strftime("%m/%d/%y %H:%M:%S")<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fast editing and reloading of vimrc configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>e :e! ~/.vimrc<cr>
autocmd! BufWritePost ~/.vimrc source ~/.vimrc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" Section: Reading and writing files {{{

set fileformats=unix,dos
set backupskip+=/private/tmp/*

" }}}
" Section: Command line editing {{{

set wildmenu
set history=200        " Keep 200 lines of command line history
set wildmode=full
set wildignore+=tags,.*.un~,*.pyc,*.o
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
" }}}
" Section: Filetype settings {{{

autocmd FileType * setlocal nolinebreak
autocmd FileType xml,xsd,xslt,javascript setlocal ts=2
" }}}
" Section: AutoCmd {{{

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
" }}}
" Section: Function definitions {{{

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  silent! %s/\s\+$//ge
  exe "normal `z"
endfunc

autocmd BufWritePre *.txt,*.js,*.sh,*.py,*.coffee :call DeleteTrailingWS()
" autocmd BufWrite *.coffee :call DeleteTrailingWS()
" autocmd BufWrite *.py :call DeleteTrailingWS()

function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  else
    return ''
  endif
endfunction

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

" vim: set et sw=2 foldmethod=marker
