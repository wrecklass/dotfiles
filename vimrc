" ~/.vimrc

" Section: Notes

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

" Section: Bootstrap

setglobal nocompatible
setglobal pastetoggle=<F2>
setglobal nobackup

filetype off
filetype plugin indent on
set rtp+=/usr/local/go/misc/vim
filetype on

let g:airline_powerline_fonts = 1
let g:airline_theme='dark'

setglobal encoding=utf8
setglobal autoread
setglobal switchbuf=usetab,newtab

" Use relative number, but show current line number
setglobal number
setglobal relativenumber

" viminfo reference:
" '10  : marks will be remembered to 10 previously edited files
" "100 : will saveup to 100 lines for each register
" :20  : up to 20 lines of command line history will be remembered
" %    : saves and restores buffer list
" n... : Name and locateion of viminfo file
" set viminfo='10,\"100,:20,%,n~/.viminfo
set viminfo='20,\"100,:100,%,n~/.viminfo

" syntax on
syntax enable

packadd! matchit

" Section: Moving around, searching, patterns and tags

set smartcase
set incsearch
set hlsearch
set ignorecase
setglobal path=.,,

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

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
" Open the error file in a new Tab by switchign to the buffer and:
"   <leader>co
"
noremap <leader>cc :botright cope<cr>
noremap <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
noremap <leader>n :cn<cr>
noremap <leader>p :cp<cr>

" Section: Displaying text

setglobal display=lastline
setglobal scrolloff=2
setglobal sidescrolloff=5
setglobal lazyredraw
set cmdheight=2

" Section: Windows

set ruler
set laststatus=2
set showtabline=2
" When using airline, this doesn't matter
if empty(&g:statusline)
  "set statusline=%<%-40.50F\ %h%m%r=%-14.(%l/%L,%c%V%)\ %P
  set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
endif
setglobal titlestring=%{v:progname}\ %{tolower(empty(v:servername)?'':'--servername\ '.v:servername.'\ ')}%{fnamemodify(getcwd(),':~')}%{exists('$SSH_TTY')?'\ <'.hostname().'>':''}
setglobal iconstring=%{tolower(empty(v:servername)?v:progname\ :\ v:servername)}%{exists('$SSH_TTY')?'@'.hostname():''}

autocmd SourcePre */macros/less.vim setglobal laststatus=0 showtabline=0

" From tpope C-j and C-k just toggle
nnoremap <C-j> <C-w>w
nnoremap <C-k> <C-w>W
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" switch window and maximize
" map <C-j> <C-W>j
" map <C-k> <C-W>k

" Section: GUI

" Don't use GVim...
setglobal mousemodel=popup
setglobal mouse=a
" Allow the mouse to interact with tabs:
if has ("gui")
  set guifont=Consolas:h9:cANSI
endif


" Section: Messages and Info

set novisualbell
set noerrorbells
set showcmd
set t_vb=
set tm=500

" Section: Editing text and indent

" Tabs:
setglobal tabstop=2
setglobal shiftwidth=2
setglobal expandtab

" Indenting:
set nocindent
set nosmartindent


setglobal textwidth=78
setglobal backspace=2
setglobal complete-=i         " Searching includes can be slow
setglobal infercase
setglobal showmatch
setglobal virtualedit=block

setglobal noshiftround
setglobal nosmarttab
setglobal noautoindent
setglobal omnifunc=syntaxcomplete#Complete
setglobal completefunc=syntaxcomplete#Complete

autocmd FileType json set sw=2 et

" Section: Folding and Comments

if has('folding')
  setglobal foldmethod=manual
  setglobal foldopen+=jump
endif
" setglobal commentstring=\"%s


autocmd FileType c,cpp,cs,java        setlocal commentstring=//\ %s
autocmd FileType desktop              setlocal commentstring=#\ %s
autocmd FileType sql                  setlocal commentstring=--\ %s
autocmd FileType xdefaults            setlocal commentstring=!%s

" Using vim-commentary for comment toggle

" Section: Maps

" Set the map keys leader to comma:
let mapleader = ","
let g:mapleader = ","

setglobal timeoutlen=2500
setglobal ttimeoutlen=100

if has('digraphs')
  digraph ,. 8230
endif
  
inoremap <C-J>        <Down>
inoremap <C-K><C-K>   <Up>

" typing ,w will write file
nnoremap <leader>w :w!<cr>
" typing ,q will write file and quit
nnoremap <leader>q :wq<cr>

" Toggle line numbers
nnoremap \l :setlocal number!<cr>

" Toggle Paste mode
nnoremap \o :setlocal paste!<cr>

" Turn off hlsearch temporarily
nnoremap \q :nohlsearch<cr>
" noremap j gj
" noremap k gk

" Use ,pp to toggle Paste mode
noremap <leader>pp :setlocal paste!<cr>

noremap <leader>h :nohlsearch<cr>

noremap <leader>l :setlocal relativenumber!<cr>

" ,m to erase all C-M's in a Dos file. Remembers location
noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

noremap <space> /
noremap <c-space> ?

" noremap \ :'a,'bs/^/  /g<C-M>
" noremap = :'a,'bs/^ //g<C-M>

" noremap <leader>s ?(<CR>ldt,pldt)%p

" Section: Reading and writing files

setglobal fileformats=unix,dos
setglobal backupskip+=/private/tmp/*

" Section: Command line editing

set wildmenu
set history=200        " Keep 200 lines of command line history
set wildmode=full
set wildignore+=tags,.*.un~,*.pyc

" Section: Filetype settings

autocmd FileType * setlocal nolinebreak
autocmd FileType xml,xsd,xslt,javascript setlocal ts=2

" Section: AutoCmd

" Take from the Debian package and the example on $VIM/vim_examples
if has("autocmd")

  " filetype plugin indent on

  au BufReadPost *
        \  if line("'\"") > 0 && line("'\"") <= line("$") |
        \    exe "normal! g'\"" |
        \  endif

  set viminfo^=%
  au FileType text set tw=78

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

setglobal backupskip+=*.asc
" set viminfo=

augroup GPG
  autocmd!
  autocmd BufReadPost  *.asc :%!gpg -r stephen -q -d
  autocmd BufReadPost  *.asc |redraw!
  autocmd BufWritePre  *.asc :%!gpg -r stephen -q -e -a
  autocmd BufWritePost *.asc u
  autocmd VimLeave     *.asc :!clear
augroup END

"vim: set et sw=2 foldmethod=manual
