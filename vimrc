" Author: Stephen Martin
" File: .vimrc
" Date: 10/25/21 01:44:17
" {{{ Settings
" Force fzf.vim to work on Cygwin. Might need to unset for Unix systems.
if $UNAME == "cygwin"
  let $TERM="cygwin"
endif
" Because file permissions don't matter much to us:
set autoread
" Start this way, turn on once plugins are loaded
filetype off
source $VIMRUNTIME/defaults.vim

" let g:ale_completion_enabled = 1
" set omnifunc=ale#completion#OmniFunc
"
" Allows us to disable ctags generation
let g:gutentags_define_advanced_commands=1

let g:ft_man_open_mode='tab'

" set wildmode=longest,list,full
if v:version >= 900
  set wildoptions+=pum
endif
set wildmenu
"Ignore files
set wildignore+=*.o
set wildignore+=*~
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*
set wildignore+=**/.hg/*

if has('folding')
  set foldmethod=marker
  set foldopen+=jump
  set foldcolumn=1
endif

" nvim is supposed to be nocompatible by default
set nocompatible
" set hidden
set encoding=utf-8
set noexrc
set relativenumber
set number

" Share system clipboard
" set clipboard=unnamed

" Searching
set hlsearch
set incsearch
set smartcase
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
set t_vb=

set showcmd
set timeoutlen=500
set ttimeoutlen=100

" Having longer updatetime (default is 4000ms = 4 s) leads to
" noticeable delays and poor user experience
set updatetime=50

" Ok, leave it alone, because we don't give a shit. Tabs are the devil.
" set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab
set nosmartindent
set formatoptions+=l

" Insert tabs according to Shiftwidth
set nosmarttab

" Wrap lines on screen, but see textwidth
set wrap

" Don't break long lines
set textwidth=0

set matchpairs+=<:>

" Highlight the cursor line and column on display
set cursorline
set cursorcolumn

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
set nowb

" Where to store undo history
set undodir=~/.cache/undodir
set undofile
set undolevels=5000

" Don't default to Read Only in vimdiff
set noro

set termguicolors
set showmode
set completeopt=menuone,noinsert,noselect
set signcolumn=yes

" No column ruler at 80 characters.
set colorcolumn=

set pastetoggle=<F2>

" Give more space for displaying messages.
set cmdheight=2
set display=lastline

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=5

" Not really meaningful with 'set wrap'
set sidescrolloff=5

" DOn't redraw while executing macros for better performance
set lazyredraw

" Show the line and column number of the cursor position
set ruler

" Always show statusline
set laststatus=2

" Always show tabline
set showtabline=2

" Round indent to multiple of 'shiftwidth'.  Applies to > and <
set noshiftround

" Don't do it!
set noautoindent

" Autocomplete with ^X^O
set omnifunc=syntaxcomplete#Complete
set completefunc=syntaxcomplete#Complete

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
    set guifont=FiraCode\ Nerd\ Font\ Mono:h12
    set lines=50 columns=120
endif

" Prefer unix before dos and mac formats
set fileformats=unix,dos,mac

" Don't pass messages to |ins-completion-menu|.
" set shortmess+=c
" }}}
" {{{ Startify
" Bookmarks for Startify:
let g:startify_bookmarks = [ {'v': '~/.vimrc'}, {'b': '~/.bashrc'} ]
let g:startify_commands = [ {'i': 'ver'}, {'z': 'qa'} ]
let g:startify_custom_footer = ['', "Once you get in, There is no getting out ", '']
let g:startify_lists = [
          \ { 'type': 'bookmarks' , 'header': ['   Bookmarks']      } ,
          \ { 'type': 'files'     , 'header': ['   Recent'   ]      } ,
          \ { 'type': 'sessions'  , 'header': ['   Sessions' ]      } ,
          \ { 'type': 'commands'  , 'header': ['   Commands' ]      } ,
          \ ]

" Highlights
highlight StartifyBracket ctermfg=240
highlight StartifyFile    ctermfg=147
highlight StartifyFooter  ctermfg=240
highlight StartifyHeader  ctermfg=114
highlight StartifyNumber  ctermfg=215
highlight StartifyPath    ctermfg=245
highlight StartifySlash   ctermfg=240
highlight StartifySpecial ctermfg=240
" }}}
" {{{ Plugins

call plug#begin('~/.vim/plugged')

" Plug 'terroo/vim-simple-emoji'
" Plug 'junegunn/goyo.vim'
Plug 'rhysd/clever-f.vim'
Plug 'voldikss/vim-floaterm'
Plug 'markonm/traces.vim'

Plug 'vim-utils/vim-man'
Plug 'airblade/vim-gitgutter'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', {'do' : { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'BurntSushi/ripgrep'
Plug 'junegunn/vim-peekaboo'
Plug 'ludovicchabant/vim-gutentags'
" Plug 'stsewd/fzf-checkout.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'       " :GV to browse git history
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
" Plug 'octol/vim-cpp-enhanced-highlight'
" Go complete, quite old
" Plug 'fisadev/vim-sane-gocomplete'

Plug 'terryma/vim-smooth-scroll'

" Plug 'ap/vim-css-color'

" Just really really slow:
" Plug 'frazrepo/vim-rainbow'

Plug 'mhinz/vim-startify'
Plug 'ervandew/supertab'

" Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'vim-scripts/loremipsum'
Plug 'wrecklass/wc.vim'
" Plug 'kkew3/wc.vim'

" Ok, colorschemes:
" Plug 'haystackandroid/carbonized'
" Plug 'haystackandroid/vimspectr'
Plug 'gruvbox-community/gruvbox'
Plug 'nlknguyen/papercolor-theme'
" Plug 'sainnhe/gruvbox-material'
" Plug 'hardhackerlabs/theme-vim', {'as' : 'hardhacker'}
" Plug 'haystackandroid/snow'
Plug 'tomasiser/vim-code-dark'

" Powerline Status Line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" ***** Only if we need em: *****
" LOOKUP RFCs:
" Plug 'mhinz/vim-rfc'

" SNIPPETS FOR HTML/CSS:
" Plug 'mattn/emmet-vim'

" MAKE/COMPILER DISPATCHER:
" Plug 'tpope/vim-dispatch'

call plug#end()

let g:fzf_preview_window = ['hidden,right,33%', 'ctrl-/']
let g:floaterm_autohide = 0
let g:floaterm_autoclose = 2
let g:floaterm_height = 34
let g:floaterm_width = 120

" }}}
" {{{ ColorScheme

try
  syntax enable
  syntax on
  " We want dark anyway
  set background=dark

  let g:gruvbox_italic=1

  " colorscheme gruvbox-material
  " colorscheme gruvbox

  " highlight Statement guifg=#569CD6
  " highlight Function guifg=#4EB9C0
  " highlight Conditional guifg=LightGreen
  " highlight Keyword     guifg=#569CD6
  " highlight Statement guifg=#569cd6
  " highlight Conditional guifg=#569cd6
  " highlight Repeat guifg=#569cd6
  " highlight Label guifg=#569cd6
  " highlight Operator guifg=#569cd6
  " highlight Exception guifg=#569cd6
  " highlight PreProc guifg=#569cd6
  " highlight Include guifg=#569cd6
  " highlight Define guifg=#569cd6
  " highlight Macro guifg=#569cd6
  " highlight PreCondit guifg=#569cd6
  " highlight String guifg=#6A9955 ctermfg=17
  " highlight Comment guifg=#4E7D39 ctermfg=17
  " highlight pyConditional guifg=#569cd6
  " highlight pythonConditional guifg=#569cd6
  " highlight pythonException guifg=#569cd6
  " highlight pythonRepeat guifg=#569cd6
  " highlight pythonOperator guifg=#569cd6

  " let g:hardhacker_darker = 1

  " colorscheme hardhacker
  " colorscheme carbonized-dark

  " let g:vimspectrLineNr = 'on'
  " let g:vimspectrItalicComment = 'on'
  " colorscheme vimspectrgrey-dark

  " colorscheme snow

  let g:codedark_conservative=1
  let g:codedark_modern=0
  let g:codedark_italics=1
  let g:codedark_transparent=0
  colorscheme codedark
  highlight Folded guibg=#223E55 guifg=#AFAFAF gui=italic ctermfg=144 ctermbg=24 cterm=italic
  highlight String guifg=#87E7FE ctermfg=17
  highlight Identifier guifg=LightGreen
  highlight Function guifg=#4EB9C0
  highlight CursorLine guibg=#41403f
  let g:airline_theme='codedark'

  " let g:PaperColor_Theme_Options = {
  " \   'theme': {
  " \     'default.dark': {
  " \       'override' : {
  " \         'color00'       : ['#080808', '232'],
  " \         'cursorline'    : ['#082838', '238'],
  " \         'linenumber_fg' : ['#767676', '243'],
  " \         'linenumber_bg' : ['#082838', '232'],
  " \         'folded_bg'     : ['#223e55', '242'],
  " \         'folded_fg'     : ['#afafaf', '235'],
  " \       }
  " \     }
  " \   }
  " \ }

  " colorscheme PaperColor
catch
endtry

highlight Normal guibg=background
highlight QuickFixLine guibg=#65000B ctermbg=darkred

" Airline Status Bar
let g:airline_powerline_fonts=1

" let g:airline_theme='snow_dark'

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
" let g:airline_theme='base16_gruvbox_dark_hard'
" let g:airline_theme='jet'
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
" }}}
" {{{ Mappings

let mapleader = " "
let g:mapleader = " "
" Terminal:
" let g:terminal_height = -10
" set termwinsize=18x200
" nnoremap <leader>` :botright terminal<CR>
" tnoremap <c-j> <c-\><c-n><c-w>j
" tnoremap <c-k> <c-\><c-n><c-w>k
" set shell=/bin/bash

nnoremap <leader><      :cprev<CR>
nnoremap <leader>>      :cnext<CR>
nnoremap <leader>sv     :source $MYVIMRC<CR>
nnoremap <leader>so     :source $MYVIMRC<CR>
nnoremap <leader><CR>   :source $MYVIMRC<CR>
nnoremap <leader>w      :w!<CR>
nnoremap <c-s>          :w<CR>

" typing leader z will write file and quit, like ZZ
nnoremap <leader>z          :wq<CR>
" Or exit without saving changes
nnoremap <leader>Q          :q!<CR>

nnoremap <leader>vh  :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>bs  /<C-R>=escape(expand("<cword>"), "/")<CR><CR>
nnoremap <leader>u   :UndotreeToggle<CR>
nnoremap <leader>pv  :Ex<CR>
nnoremap <leader>+   :resize +5<CR>
nnoremap <leader>=   :resize +5<CR>
nnoremap <leader>-   :resize -5<CR>
nnoremap <leader>rp  :resize 100<CR>
" nnoremap <leader>ee  oif err != nil {<CR>log.Fatalf("%+v\n", err)<CR>}<CR><esc>kkI<esc>
" nnoremap <leader>cpu a%" PRIu64 "<esc>

"  <Leader>s to start a substitution
nnoremap <leader>s   :%s/
nnoremap <leader>S   :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

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
nnoremap \q :set hlsearch!<CR>:setlocal hlsearch?<CR>
noremap <leader>h :setlocal hlsearch!<CR>:setlocal hlsearch?<CR>

" Globally search and replace the <word> under the cursor
nnoremap  <leader>*  :%s/\<<c-r><c-w>\>//g<Left><Left>


" Toggle case sensitive search
nnoremap <leader>i :setlocal ic!<CR>:setlocal ic?<CR>

" F2 = pastetoggle
" Repeat last search, because reasons
nnoremap <F3> n

" Do a word count of the buffer
nnoremap <F4> :WC<CR>

" Show list of buffers and then prompt for which to switch to
nnoremap <F5> :buffers<CR>:buffer<Space>

" Toggle from / to \ or vice versa on selected line(s)
function! ToggleSlash(independent) range
  let from = ''
  for lnum in range(a:firstline, a:lastline)
    let line = getline(lnum)
    let first = matchstr(line, '[/\\]')
    if !empty(first)
      if a:independent || empty(from)
        let from = first
      endif
      let opposite = (from == '/' ? '\' : '/')
      call setline(lnum, substitute(line, from, opposite, 'g'))
    endif
  endfor
endfunction
command! -bang -range ToggleSlash <line1>,<line2>call ToggleSlash(<bang>1)
noremap <silent> <F8> :ToggleSlash<CR>


" <leader>m to erase all ^M in a Dos file. Remembers location
noremap <leader>m mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fast editing and reloading of vimrc configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>e :e! $MYVIMRC<cr>
map <leader>ev :vsplit $MYVIMRC<cr>
augroup SourceMyVimRc
  autocmd! BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" Use <space>pp to toggle Paste mode
""""""""""Use F2 Instead""""""""""
" noremap <leader>pp :setlocal paste!<CR>
" nnoremap \o :setlocal paste!<CR>

" Swap lines in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<+1<CR>gv=gv

nnoremap <c-j>  <C-W>w
nnoremap <c-k>  <C-W>W
nnoremap <c-h>  <C-W>h
nnoremap <c-l>  <C-W>l

"noremap <space> 8j
" noremap <c-space> 8k
" Smooth movements
" noremap <silent> <space> :call smooth_scroll#down(&scroll,20,1)<CR>
noremap <silent> <c-b>   :call smooth_scroll#up(&scroll,20,1)<CR>
noremap <silent> <c-f>   :call smooth_scroll#down(&scroll,20,1)<CR>
noremap <silent> <c-u>   :call smooth_scroll#up(&scroll/2,20,1)<CR>
noremap <silent> <c-d>   :call smooth_scroll#down(&scroll/2,20,1)<CR>

" Remap Y to be consistent with C and D
nnoremap Y yg$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Make b movement inclusive
" onoremap b vb

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

nmap     <leader>nt             <c-w>T
nmap     <silent>  <C-n>        :NERDTreeToggle<CR>
nmap     <leader>n              :NERDTreeToggle<CR>
map      \|                     :NERDTreeFind<CR>

noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <silent> <Home> <C-O><Home>

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
ab tea ☕
ab ptr ▶
ab cbe ▄
ab cbe2 ■
ab okk ✓
ab str ★

" nnoremap bs i#!/bin/bash<ESC>0
nnoremap be i#!/usr/bin/env bash<ESC>0
nnoremap bp i#!/usr/bin/env python<ESC>0
nnoremap br i#!/usr/bin/env ruby<ESC>0

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
" noremap <leader>g :vimgrep // **/*<left><left><left><left><left><left>

" Vimgreps in the current file
noremap <leader><space> :vimgrep // <C-R>%<HOME><right><right><right><right><right><right><right><right><right>

map <nowait><leader>c :Colors<CR>
nnoremap <leader>I    :Startify<CR>

" FZF Search
nnoremap <silent> <leader>b :Buffers<CR>
" nnoremap <silent> <leader>i :Files<CR>
nnoremap <silent> <leader>f :Rg<CR>
" nnoremap <silent> <leader>/ :BLines<CR>
nnoremap <silent> <leader>' :Marks<CR>
nnoremap <silent> <leader>g :Commits<CR>
nnoremap <silent> <leader>H :Helptags<CR>
nnoremap <silent> <leader>hh :History<CR>
nnoremap <silent> <leader>h: :History:<CR>
nnoremap <silent> <leader>W :Windows<CR>
nnoremap <silent> <leader>M :Maps<CR>
nnoremap <silent> <leader>t :FloatermToggle<CR>

" Easy bracket pairing
inoremap<nowait>" ""<left>
inoremap<nowait>' ''<left>
inoremap<nowait>( ()<left>
inoremap<nowait>[ []<left>
inoremap<nowait>{ {}<left>

command! BufOnly silent! execute "%bd|e#"

" }}}
" {{{ Status line

" When using airline, this doesn't matter
if empty(&g:statusline)
  "set statusline=%<%-40.50F\ %h%m%r=%-14.(%l/%L,%c%V%)\ %P
  set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
endif

set titlestring=%{v:progname}\ %{tolower(empty(v:servername)?'':'--servername\ '.v:servername.'\ ')}%{fnamemodify(getcwd(),':~')}%{exists('$SSH_TTY')?'\ <'.hostname().'>':''}
set iconstring=%{tolower(empty(v:servername)?v:progname\ :\ v:servername)}%{exists('$SSH_TTY')?'@'.hostname():''}lightlight

augroup SPRE
  autocmd!
  autocmd SourcePre */macros/less.vim set laststatus=0 showtabline=0
augroup END

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

  augroup FileTypes
   " Remove on reload
    autocmd!

    filetype plugin indent on
    " Move to the last position ('") when this file was opened
    autocmd BufReadPost *
            \  if line("'\"") > 0 && line("'\"") <= line("$") |
            \    exe "normal! g'\"" |
            \  endif

    " set viminfo^=%
    set viminfo='20,\"100,:100,%,n~/.viminfo
    packadd! matchit

    " Colorful brackets/parens
    " must be done AFTER plugin loads
    let g:rainbow_active = 1

    autocmd FileType c,cpp             setlocal path+=/usr/include include&
    autocmd FileType sh,zsh,csh,tcsh   setlocal include=^\\s*\\%(\\.\\\|source\\)\\s
    autocmd FileType dosbatch          setlocal include=^call | let &l:sua = tr($PATHEXT, ';', ',')
    autocmd FileType json              setlocal shiftwidth=2 expandtab

    autocmd FileType sh,zsh,csh,tcsh,dosbatch let &l:path =
          \ tr($PATH, has('win32') ? ';' : ':', ',') . ',.'

    autocmd FileType lua
          \ if expand('%:p') =~# '/awsome/' |
          \   let &l:path = expand('~/.config/awsome') . ',/etc/xdg/awsome,/usr/share/awsome/lib,' . &l:path |
          \ endif

    autocmd FileType ruby setlocal tags=./tags;

    autocmd BufWritePost *.rb silent !ctags -R .
  augroup END

  augroup CursorSettings
    autocmd!
    " Alternative codes:
    "  1 -> blinking block
    "  2 -> solid block
    "  3 -> blinking underscore
    "  4 -> solid underscore
    "  5 -> blinking vertical bar
    "  6 -> solid vertical bar

    autocmd VimEnter * let &t_SI.="\e[5 q" "SI = INSERT mode
    autocmd VimEnter * let &t_SR.="\e[3 q" "SR = REPLACE mode
    autocmd VimEnter * let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

    autocmd VimLeave * let &t_EI.="\e[1 q" | normal i
  augroup END

else
  set autoindent
endif " has ("autocmd")
" }}}
