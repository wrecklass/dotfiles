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

" nvim is supposed to be nocompatible by default
" This has to come before defaults.vim with vim91
set nocompatible
source $VIMRUNTIME/defaults.vim

" let g:ale_completion_enabled = 1
" set omnifunc=ale#completion#OmniFunc
"
" Allows us to disable ctags generation
" let g:gutentags_define_advanced_commands=1

" Turn off vimtips auto display
let g:fortune_vimtips_auto_display = 0

let g:ft_man_open_mode='tab'

" set wildmode=longest,list,full
if v:version >= 900
  set wildoptions+=pum
  set smoothscroll
endif
" Set in defaults.vim
" set wildmenu

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
set noerrorbells
set belloff=all
set novisualbell
set t_vb=

" Set in defaults.vim
" set showcmd

" set timeoutlen=500
" Set in defaults.vim
" set ttimeoutlen=100

" Having longer updatetime (default is 4000ms = 4 s) leads to
" noticeable delays and poor user experience
set updatetime=50

" Ok, leave it alone, because we don't give a shit. Tabs are the devil.
" set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab
set nosmartindent
set formatoptions+=lj

" Insert tabs according to Shiftwidth
set nosmarttab

" Wrap lines on screen, but see textwidth
set wrap

" Don't break long lines
set textwidth=0

set matchpairs+=<:>

" Don't Highlight the cursor line and column on display
set cursorline
" Highlight the number column only
set cursorlineopt=number

" No column ruler at 80 characters.
set nocursorcolumn
" No column ruler
set colorcolumn=

" Where the backspace key works
" Set in defaults.vim
" set backspace=eol,start,indent

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
set nowritebackup

" Where to store undo history
set undodir=~/.cache/undodir
set undofile
set undolevels=5000

" Don't default to Read Only in vimdiff
set noreadonly

set termguicolors
set showmode
set completeopt=menuone,noinsert,noselect
set signcolumn=yes

set pastetoggle=<F2>

" Give more space for displaying messages.
set cmdheight=2
set display=lastline

" Minimal number of screen lines to keep above and below the cursor.
" Set in defaults.vim
" set scrolloff=5

" Not really meaningful with 'set wrap'
set sidescrolloff=5

" DOn't redraw while executing macros for better performance
set lazyredraw

" Show the line and column number of the cursor position
" Makes no difference with Airline status line.
" Set in defaults.vim
" set ruler

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
    set guifont=FiraCode\ Nerd\ Font\ Mono\ 12
    set lines=50 columns=120
endif

" Prefer unix before dos and mac formats
set fileformats=unix,dos,mac

" Don't pass messages to |ins-completion-menu|.
" set shortmess+=c
" }}}
" {{{ Plugins

call plug#begin('~/.vim/plugged')

" Plug 'terroo/vim-simple-emoji'
" Plug 'junegunn/goyo.vim'
Plug 'rhysd/clever-f.vim'
Plug 'voldikss/vim-floaterm'
Plug 'markonm/traces.vim'

Plug 'vim-utils/vim-man'
" Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-signify'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', {'do' : { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'BurntSushi/ripgrep'
Plug 'junegunn/vim-peekaboo'
" Plug 'ludovicchabant/vim-gutentags'
" Plug 'stsewd/fzf-checkout.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'       " :GV to browse git history
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-vinegar'
Plug 'rust-lang/rust.vim'
if $UNAME != "cygwin" && $MTYPE != "Ras"
  Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
endif
" Plug 'octol/vim-cpp-enhanced-highlight'
" Go complete, quite old
" Plug 'fisadev/vim-sane-gocomplete'

Plug 'terryma/vim-smooth-scroll'

Plug 'raimondi/delimitmate'

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
" Plug 'vimpostor/vim-lumen'
" Plug 'haystackandroid/carbonized'
" Plug 'haystackandroid/vimspectr'
" Plug 'gruvbox-community/gruvbox'
Plug 'nlknguyen/papercolor-theme'
" Plug 'sainnhe/gruvbox-material'
" Plug 'hardhackerlabs/theme-vim', {'as' : 'hardhacker'}
" Plug 'haystackandroid/snow'
" Plug 'tomasiser/vim-code-dark'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

Plug 'openuado/vimtips-fortune'

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

  " let g:gruvbox_italic=1

  " colorscheme gruvbox-material
  " colorscheme gruvbox

  " highlight Statement guifg=#569CD6
  " highlight Function guifg=#4EB9C0
  " highlight Conditional guifg=LightGreen
  " highlight Keyword     guifg=#569CD6
  " highlight Statement guifg=#569CD6
  " highlight Conditional guifg=#569CD6
  " highlight Repeat guifg=#569CD6
  " highlight Label guifg=#569CD6
  " highlight Operator guifg=#569CD6
  " highlight Exception guifg=#569CD6
  " highlight PreProc guifg=#569CD6
  " highlight Include guifg=#569CD6
  " highlight Define guifg=#569CD6
  " highlight Macro guifg=#569CD6
  " highlight PreCondit guifg=#569CD6
  " highlight String guifg=#6A9955 ctermfg=17
  " highlight Comment guifg=#4E7D39 ctermfg=17
  " highlight pyConditional guifg=#569CD6
  " highlight pythonConditional guifg=#569CD6
  " highlight pythonException guifg=#569CD6
  " highlight pythonRepeat guifg=#569CD6
  " highlight pythonOperator guifg=#569CD6
  " END GRUVBOX

  " let g:hardhacker_darker = 1
  " colorscheme hardhacker
  " END HARDHACKER
  " colorscheme carbonized-dark

  " let g:vimspectrLineNr = 'on'
  " let g:vimspectrItalicComment = 'on'
  " colorscheme vimspectrgrey-dark
  " END VIMSPECTRGREY

  " let g:codedark_conservative=1
  " let g:codedark_modern=0
  " let g:codedark_italics=1
  " let g:codedark_transparent=0
  " colorscheme codedark
  " highlight Folded guibg=#223E55 guifg=#AFAFAF gui=italic ctermfg=144 ctermbg=24 cterm=italic
  " highlight String guifg=#87E7FE ctermfg=17
  " highlight Identifier guifg=LightGreen
  " highlight Function guifg=#4EB9C0
  " highlight CursorLine guibg=#41403F
  " let g:airline_theme='codedark'
  " END CODEDARK

  let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.dark': {
  \       'allow_italic'  : 1,
  \       'override' : {
  \         'color05'       : ['#00875F', '28'],
  \         'color10'       : ['#0087DF', '31'],
  \         'cursorline'    : ['#002F57', '24'],
  \         'cursorcolumn'  : ['#002F57', '24'],
  \         'folded_bg'     : ['#223E55', '242'],
  \         'folded_fg'     : ['#AFAFAF', '146'],
  \       }
  \     }
  \   }
  \ }

  " \         'color00'       : ['#080808', '232'],
  " \         'linenumber_bg' : ['#082838', '232'],
  " \         'linenumber_fg' : ['#767676', '243'],
  colorscheme PaperColor
  " I like italics
  highlight Folded gui=italic cterm=italic
  " highlight Error guibg=NONE guifg=#EF0000
  " let g:airline_theme='papercolor'
  " END PAPERCOLOR
catch
endtry

" highlight Normal guibg=background
highlight Normal guibg=NONE
highlight SignColumn guibg=NONE
highlight LineNr guibg=NONE guifg=#747474

highlight QuickFixLine guibg=NONE guifg=#CFCFCF ctermbg=darkred
" highlight QuickFixLine guibg=#65000B guifg=#CFCFCF ctermbg=darkred

" Airline Status Bar
let g:airline_powerline_fonts=1

let g:airline_theme='base16_google_dark'
" let g:airline_theme='google_dark'
" color00 = Background
" }}}
" {{{ Mappings

let mapleader = " "
let g:mapleader = " "

" [N] -- Titlise A Line
nmap ,t :s/.*/\L&/<bar>:s/\<./\u&/g<cr>

let g:which_key_map = {}

nnoremap <silent> <leader>  :WhichKey '<Space>'<CR>
nnoremap <silent> b         :WhichKey 'b'<CR>
nnoremap <silent> ,         :WhichKey ','<CR>
autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')


" Terminal:
let g:terminal_height = -10
set termwinsize=18x200
set shell=/bin/bash
nnoremap <leader>` :botright terminal<CR>
let g:which_key_map['`'] = "btm Term"

tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k

" map for cprev and cnext, also open folds at location
nnoremap <leader><      :cprev<CR>zv
let g:which_key_map['<'] = 'cprev'
nnoremap <leader>>      :cnext<CR>zv
let g:which_key_map['>'] = 'cnext'

nnoremap <Tab>          gt
nnoremap <S-Tab>        gT

nnoremap <leader>sv     :source $MYVIMRC<CR>
nnoremap <leader>so     :source $MYVIMRC<CR>
nnoremap <leader><CR>   :source $MYVIMRC<CR>
nnoremap <leader>w      :w!<CR>
nnoremap <c-s>          :w<CR>

" typing leader z will write file and quit, like ZZ
nnoremap <leader>z          :wq<CR>
" Or exit without saving changes
nnoremap <leader>Q          :q!<CR>

" Hilariously this turns out to be mapped to K already.
" Except K also opens man pages for some non-vim words
" nnoremap <leader>vv  :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>vh  K
" nnoremap <leader>bs  /<C-R>=escape(expand("<cword>"), "/")<CR><CR>
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
let g:which_key_map.S =  'Search&Replace'

" nnoremap <leader>gll :let g:_search_term = expand("%")<CR><bar>:Gclog -- %<CR>:call search(g:_search_term)<CR>
" nnoremap <leader>gln :cnext<CR>:call search(_search_term)<CR>
" nnoremap <leader>glp :cprev<CR>:call search(_search_term)<CR>

" Easy vertical split
nnoremap  <leader>v    :vs<CR>
nnoremap  <leader>h    :sp<CR>

"============================================="
" split automatically if window doesn't exist "
"============================================="
function! WinMove(key) abort
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr()) "we haven't moved
    if (match(a:key,'[jk]')+1) "we want to go up/down
      wincmd s
    elseif (match(a:key, '[hl]')+1) " we want to go left/right
      wincmd v
    endif
    exec "wincmd ".a:key
  endif
endfunction

map <c-h> :call WinMove('h')<CR>
map <c-k> :call WinMove('k')<CR>
map <c-l> :call WinMove('l')<CR>
map <c-j> :call WinMove('j')<CR>

" Replaced by above:
" nnoremap <c-j>  <C-W>w
" nnoremap <c-k>  <C-W>W
" nnoremap <c-h>  <C-W>h
" nnoremap <c-l>  <C-W>l

" end highlighting by searching for garbage
nnoremap  <leader>;    /xckla<CR>

nnoremap <F6> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

nnoremap <leader>j  :m+<CR>==
nnoremap <leader>k  :m-2<CR>==

" Toggle line numbers
nnoremap \l       :setlocal number!<CR>
noremap <leader>l :setlocal relativenumber!<CR>
let g:which_key_map.l = 'toggle RelNum'
map     <F12>     :setlocal number!<CR>

" Turn off hlsearch temporarily
" nnoremap \q :set hlsearch!<CR>:setlocal hlsearch?<CR>
noremap <leader>H :setlocal hlsearch!<CR>:setlocal hlsearch?<CR>
let g:which_key_map.H = 'toggle hlsearch'

" Globally search and replace the <word> under the cursor
" nnoremap  <leader>*  :%s/\<<c-r><c-w>\>//g<Left><Left>

" Toggle case sensitive search
" nnoremap <leader>i :setlocal ic!<CR>:setlocal ic?<CR>

" F2 = pastetoggle
" Repeat last search, because reasons
nnoremap <F3> n

" Do a word count of the buffer
nnoremap <F4> :WC<CR>

" Show list of buffers and then prompt for which to switch to
nnoremap <F5> :buffers<CR>:buffer<Space>

" Toggle from / to \ or vice versa on selected line(s)
function! ToggleSlash(independent) range abort
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
" noremap <leader>m mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fast editing and reloading of vimrc configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>e :e! $MYVIMRC<cr>
map <leader>ev :vsplit $MYVIMRC<cr>
augroup SourceMyVimRc
  autocmd! BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

augroup PHP
  autocmd BufEnter *.php :%s/[ \t\r]\+$//e
augroup END

" Use <space>pp to toggle Paste mode
""""""""""Use F2 Instead""""""""""
" noremap <leader>pp :setlocal paste!<CR>
" nnoremap \o :setlocal paste!<CR>

" Swap lines in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<+1<CR>gv=gv

"noremap <space> 8j
" noremap <c-space> 8k
" Smooth movements
" noremap <silent> <space> :call smooth_scroll#down(&scroll,20,1)<CR>
noremap <silent> <c-b>   :call smooth_scroll#up(&scroll,40,1)<CR>
noremap <silent> <c-f>   :call smooth_scroll#down(&scroll,40,1)<CR>
noremap <silent> <c-u>   :call smooth_scroll#up(&scroll/2,40,1)<CR>
noremap <silent> <c-d>   :call smooth_scroll#down(&scroll/2,40,1)<CR>

" Up and Down arrows perform simple scroll on center line of text
nnoremap <Down> gjzz
nnoremap <Up> gkzz

" grep word under cursor and place in quickfix list
command! -nargs=+ GG silent execute "Ggrep! -niI --exclude-standard --untracked ".string(<q-args>)
nnoremap <silent> <Leader>gg :GG <C-r><C-w><CR>
vnoremap <silent> <Leader>gg y:GG <C-r>"<CR>

" Remap Y to be consistent with C and D
nnoremap Y yg$

" Repeat search center and reveal in fold
nnoremap n nzzzv
nnoremap N Nzzzv

" After Joining line, move back to original location
nnoremap J mzJ`z

" Move paragraph and center
nnoremap {   {zz
nnoremap }   }zz

" Make b movement inclusive
" onoremap b vb

" greatest remap ever, in Visual only delete current
" selection and then paste current registry
xnoremap <leader>p "_dP
" Paste system clipboard to buffer
nnoremap <leader>p "+p
" Copy N lines to system clipboard
nnoremap <leader>c "+yy

" Paste in system clipboard with ^P -- Insert mode
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

nnoremap bs ggO<BS>#!/usr/bin/env bash<ESC>0
nnoremap be ggO<BS>#!/usr/bin/env bash<ESC>0
nnoremap bp ggO<BS>#!/usr/bin/env python<ESC>0
nnoremap br ggO<BS>#!/usr/bin/env ruby<ESC>0

" Map jj to Escape easily
" Really helpful when in insert mode and start typing j to navigate
" inoremap jj  <Esc>

inoremap <C-J>        <Down>
" inoremap <C-K><C-K>   <Up>

" When you press gv you vimgrep after the selected text
" vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
" vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Pressing <leader>r sets up search and replace on visual selection
" vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>
" let g:which_key_map.r = 'visual vimgrep'

" Open vimgrep and put the cursor in the right position
" noremap <leader>g :vimgrep // **/*<left><left><left><left><left><left>

" noremap <leader><space> :vimgrep // <C-R>%<HOME><right><right><right><right><right><right><right><right><right>

" Vimgreps in the current file
" noremap <leader><space> :vimgrep // <C-R>%<HOME><right><right><right><right><right><right><right><right><right>

" map <nowait><leader>c :Colors<CR>
nnoremap <leader>I    :Startify<CR>

" FZF Search
nnoremap <silent> <leader>b :Buffers<CR>
" nnoremap <silent> <leader>i :Files<CR>
nnoremap <silent> <leader>f :Rg<CR>
" nnoremap <silent> <leader>/ :BLines<CR>
nnoremap <silent> <leader>' :Marks<CR>
nnoremap <silent> <leader>g :Commits<CR>
nnoremap <silent> <leader>T :Helptags<CR>
nnoremap <silent> <leader>hh :History<CR>
nnoremap <silent> <leader>h: :History:<CR>
nnoremap <silent> <leader>W :Windows<CR>
nnoremap <silent> <leader>M :Maps<CR>
nnoremap <silent> <leader>t :FloatermToggle<CR>
let g:which_key_map.t = 'Float Term'

" Easy bracket pairing
" inoremap<nowait>" ""<left>
" inoremap<nowait>' ''<left>
" inoremap<nowait>( ()<left>
" inoremap<nowait>[ []<left>
" inoremap<nowait>{ {}<left>

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
" {{{ Visualselection
function! CmdLine(str) abort
  call feedkeys(":" . a:str)
  " Old way
  " exe "menu Foo.Bar :" . a:str
  " emenu Foo.Bar
  " unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range abort
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
" {{{ Startify
" Bookmarks for Startify:
let g:startify_bookmarks = [ {'v': '~/.vimrc'}, {'b': '~/.bashrc'} ]
let g:startify_commands = [ {'i': 'ver'}, {'z': 'qa'}, {'s': 'source $MYVIMRC'}, {'p': 'PlugUpdate'} ]
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
" {{{ Functions

" For some reason highlight commands don't work with the Windows EXE vim
function! s:HighLightsCD() abort
  highlight Folded guibg=#223E55 guifg=#AFAFAF gui=italic ctermfg=144 ctermbg=24 cterm=italic
  highlight String guifg=#87E7FE ctermfg=17
  highlight Identifier guifg=LightGreen
  highlight Function guifg=#4EB9C0
  highlight QuickFixLine guibg=#95000B guifg=#CFCFCF ctermbg=darkred
  highlight Normal guibg=background
  " highlight CursorLine guibg=#223E55
  highlight CursorLine guibg=#002F57
  set background=dark
  redraw
endfunction
" call <SID>HighLightsCD()
command! Codelights call <SID>HighLightsCD()

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! s:BufcloseCloseIt() abort
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

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff() abort
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
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
    " Set in defaults.vim
    " autocmd BufReadPost *
    "       \  if line("'\"") > 0 && line("'\"") <= line("$") |
    "       \    exe "normal! g'\"" |
    "       \  endif

    " set viminfo^=%
    set viminfo='20,\"100,:100,%,n~/.viminfo
    packadd! matchit

    " Colorful brackets/parens
    " must be done AFTER plugin loads
    let g:rainbow_active = 1

    autocmd FileType c,cpp,h           setlocal path+=/usr/include include&
    autocmd FileType c,cpp,h           setlocal foldmethod=syntax
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

    " autocmd BufWritePost *.rb silent !ctags -R .
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
