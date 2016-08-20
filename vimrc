" source $VIM/vim70/mswin.vim

" if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
" set filencodings=utf-8,latin1
" endif
"
set encoding=utf8

let mapleader = ","
let g:mapleader = ","

" typing ,w will write file
nmap <leader>w :w!<cr>
" typing ,q will write file and quit
nmap <leader>q :wq<cr>

set novisualbell
set noerrorbells
set t_vb=
set tm=500

" Tabs:
set tabstop=2
set shiftwidth=2
set expandtab
"runtime! plugin/sensible.vim
"runtime! plugin/tagbar.vim

if has ("gui")
  set guifont=Consolas:h9:cANSI
endif

filetype off
filetype plugin indent on
set rtp+=/usr/local/go/misc/vim
filetype on

set autoread

" For chess Portable Game Notation (pgn) files:
" au BufNewFile,BufRead *.pgn setf pgn


"Strong Encryption:
set cm=blowfish

" Indenting:
set nocindent
set nosmartindent


set ruler
" set statusline=~

set incsearch
set nobackup
set hls
set ignorecase
set smartcase
" set foldmethod=indent
" set nofoldenable

set bs=2
set switchbuf=usetab,newtab

" set tags=~/src/patchsimple_agent/tags

" switch window and maximize
" map <C-J> <C-W>j<C-W>_
" map <C-K> <C-W>k<C-W>_
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" map j gj
" map k gk

" Use ,pp to toggle Paste mode
map <leader>pp :setlocal paste!<cr>

" ,m to erase all C-M's in a Dos file. Remembers location
noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

map <space> /
map <c-space> ?

" map \ :'a,'bs/^/  /g<C-M>
" map = :'a,'bs/^ //g<C-M>

" map ,s ?(<CR>ldt,pldt)%p

" set t_Sb=[4%dm
" set t_Sf=[3%dm

"
" Stop all the auto formatting!! Sheesh!
"
" set indentkeys
" set cinkeys
" set cinwords

" set viminfo='10,\"100,:20,%,n~/.viminfo
set viminfo='20,\"100,:100,%  " read/write .viminfo, with no more
" than 50 lines of registers

set history=50        " Keep 50 lines of command line history

" syntax on
syntax enable
"colorscheme SlateDark

" Take from the Debian package and the example on $VIM/vim_eaemples
if has("autocmd")

  filetype plugin indent on

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

" Allow the mouse to interact with tabs:
set mouse=a

" Toggle TagBar on and off
"nmap <F8> :TagbarToggle<CR>

" Pathogen bundle manager:
call pathogen#infect()
" map <Leader>n <plug>NERDTreeTabsToggle<CR>
" map <Leader>t <plug>NERDTreeFocusToggle<CR>
" let g:nerdtree_tabs_open_on_console_startup=0

set laststatus=2
"set statusline=%<%-40.50F\ %h%m%r=%-14.(%l/%L,%c%V%)\ %P
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

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
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>


" Some Linux distributions set filetime in /etc/vimrc
" Clear filetype flags before changing runtimepath to force vim to reload
" them.
"if exists("g:did_load_filetype")
  "filetype off
  "filetype plugin indent off
"endif
"set runtimepath+=/c/Apps/go/misc/vim " Replace $GOROOT with ouput of: go env GOROOT
"filetype plugin indent on
"syntax on


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

