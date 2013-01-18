" ----------------------------------------
" Vundle
" ----------------------------------------
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off     " required!

let g:vundle_default_git_proto='git'
set rtp+=~/.vim/bundle/vundle/
set rtp+=~/.vim/bundle/go/
call vundle#rc()

" let Vundle manage Vundle. required! 
Bundle 'gmarik/vundle'

" ---------------
" Plugin Bundles
" ---------------

" Navigation
Bundle 'FuzzyFinder'
Bundle 'a.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'taglist.vim'
Bundle 'cscope_macros.vim'
Bundle 'Lokaltog/vim-easymotion'
" UI Additions
Bundle 'dickeytk/status.vim'
" Commands
Bundle 'tpope/vim-surround'
Bundle 'mileszs/ack.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdcommenter'
" Automatic helpers
Bundle 'Raimondi/delimitMate'
Bundle 'scrooloose/syntastic'
Bundle 'ervandew/supertab'
Bundle 'xolox/vim-session'
Bundle 'Shougo/neocomplcache'
" SnipMate
Bundle "garbas/vim-snipmate"
" SnipMate Depedancies
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "snipmate-snippets"
" Language Additions
Bundle 'mattn/zencoding-vim'
Bundle 'tpope/vim-rvm'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tangledhelix/vim-octopress'
Bundle 'tpope/vim-rails'
Bundle 'kchmck/vim-coffee-script'
Bundle 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'
" Libraries
Bundle 'tpope/vim-repeat'
Bundle 'L9'
Bundle 'genutils'

" Automatically detect file types. (must turn on after Vundle)
filetype plugin indent on

" ----------------------------------------
" Platform Specific Configuration
" ----------------------------------------

if has('win32') || has('win64')
  " Windows
  source $VIMRUNTIME/mswin.vim
  set guifont=Consolas:h11:cANSI
  set guioptions-=T " Toolbar
  set guioptions-=m " Menubar

  " Set height and width on Windows
  set lines=60
  set columns=120

  " Windows has a nasty habit of launching gVim in the wrong working directory
  cd ~
elseif has('gui_running')
  if has("gui_macvim")
    set guifont=Monaco:h14
    " e: tab page, g: gray menu, m: menu bar, t: tearoff menu items
    set guioptions=egmt
    " commands like yy will directly put content into mac clipboard
    "set clipboard=unnamed
  endif
  winsize 90 45
endif

" ----------------------------------------
" Regular Vim Configuartion (No Plugins Needed)
" ----------------------------------------

" ---------------
" Color
" ---------------
set t_Co=256 " XXX This has problem on real terminal, fix it
colorscheme inkpot

" ---------------
" File encodings
" ---------------
set fileencodings=utf-8,gbk "ucs-bom,ucs-4

" ---------------
" Backups
" ---------------
set backup
set backupdir=~/.vim/data/backup
set directory=~/.vim/data/swap

" ---------------
" UI
" ---------------
set modelines=5
set ruler " show the cursor position all the time
set nu
set wrap " wrap long text when displaying
set laststatus=2
"set cmdheight=2
"set list
" :dig for more symbols
"set listchars=tab:»·,trail:·

" ---------------
" Behaviors
" ---------------
syntax on
set shortmess=atI
set hidden " allow change to buffer while modified
set wildmenu
set cf
set history=100
set showcmd " display incomplete commands
set autowrite " Writes on make/shell commands
set wildignore+=*.o,*.obj,.git
set scrolloff=5 " Always keep 5 lines above/below the cursor
set timeoutlen=200 " Time to wait for a command (after Leader for example)

" ---------------
" Text Format
" ---------------
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set shiftwidth=4  " Tabs under smart indent
set cindent
set autoindent
set smarttab
set textwidth=80
" for better formatting for multi-byte characters
set formatoptions+=tcqMm

" ---------------
" Searching
" ---------------
set ignorecase " Case insensitive search
set smartcase " Non-case sensitive search
set incsearch
set hlsearch

" ---------------
" Visual
" ---------------
set showmatch  " Show matching brackets.
set matchtime=2 " How many tenths of a second to blink

" ---------------
" Sounds
" ---------------
set noerrorbells
set novisualbell
set t_vb=

" ---------------
" Mouse
" ---------------
if has('mouse')
  set mousehide  " Hide mouse after chars typed
  set mouse=a  " Mouse in all modes
end

" Better complete options to speed it up
set complete=.,w,b,u,U

" ----------------------------------------
" Bindings
" ----------------------------------------

let mapleader=","

" Window Movement
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>

" Fixes common typos
command W w
command Q q
abbreviate teh the

" Make line completion easier
imap <C-l> <C-x><C-l>

map <F5> :make
map <F7> :cnext
map  :w

" Jump to the exact location of the mark
nmap ' `
nnoremap ; :
nnoremap j gj
nnoremap k gk

" Switch on spell
nmap <silent> <Leader>s :setlocal spell!<CR>
nmap <silent> <Leader>v :e ~/.vimrc<CR>
set pastetoggle=<Leader>p

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Don't use Ex mode, use Q for formatting
nmap Q gqap
vmap Q gq

" In case forget to use sudo vim
cmap w!! w !sudo tee % >/dev/null

" ctrl + k to move over the last pair
"inoremap ( ():let leavechar=")"i
"inoremap [ []:let leavechar="]"i
"inoremap " "":let leavechar="\""i
"inoremap <C-k> :exec "normal f" . leavechara

" ----------------------------------------
" Auto Commands
" ----------------------------------------

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" cpp, java specific abbreviation
"autocmd filetype c,cpp,java set shiftwidth=8 | set ts=8 | set noexpandtab
autocmd filetype c,cpp,java set shiftwidth=4 | set ts=4 | set expandtab
autocmd filetype c,cpp abbreviate #i #include
autocmd filetype c,cpp abbreviate #d #define
autocmd filetype c,cpp abbreviate #e #endif
"autocmd filetype c,cpp set list | set listchars=tab:»·,trail:·
autocmd filetype c,cpp,java,go inoremap { {}<Up>o
autocmd filetype ruby setlocal shiftwidth=2
autocmd filetype help setlocal nonu
autocmd filetype html setlocal shiftwidth=2
autocmd filetype python setlocal expandtab | setlocal shiftwidth=4 | setlocal tabstop=4 | setlocal softtabstop=4
autocmd filetype tex setlocal ts=4 | setlocal sw=4 | setlocal softtabstop=4 | setlocal expandtab
autocmd filetype lua setlocal ts=2 | setlocal sw=2 | setlocal softtabstop=2 | setlocal expandtab
autocmd filetype sh setlocal ts=4 | setlocal sw=4 | setlocal softtabstop=4 | setlocal expandtab
autocmd filetype srt setlocal ts=4 | setlocal sw=4 | setlocal softtabstop=4 | setlocal expandtab
autocmd filetype vim setlocal ts=2 | setlocal sw=2 | setlocal expandtab
autocmd filetype markdown setlocal ts=2 | setlocal sw=2 | setlocal expandtab
autocmd filetype go setlocal ts=4 | setlocal sw=4 | setlocal noexpandtab
autocmd filetype go setlocal makeprg=gomake

" ----------------------------------------
" Misc.
" ----------------------------------------

" ---------------
" cscope
" ---------------
set csprg=/usr/local/bin/cscope
set cscopequickfix=s-,d-,i-,t-,e-

" ---------------
" netrw
" ---------------
let g:netrw_list_hide='^\.[^.]\+'

" ---------------
" Expand current file's path
" ---------------

" learned from "Vim Tip of the day"
" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
" (thanks Douglas Potts)
if has("unix")
    map ,e :e <C-R>=expand("%:p:h") . "/"<CR>
else
    map ,e :e <C-R>=expand("%:p:h") . "\" <CR>
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif

" ----------------------------------------
" Plugin Configuration
" ----------------------------------------

" ---------------
" ctrl.p
" ---------------

nnoremap <silent> <Leader>f :CtrlPCurWD<CR>
nnoremap <silent> <Leader>b :CtrlPBuffer<CR>

" ---------------
" SuperTab
" ---------------
" Set these up for cross-buffer completion (something Neocachecompl has a hard
" time with)
let g:SuperTabDefaultCompletionType="<c-x><c-n>"
let g:SuperTabContextDefaultCompletionType="<c-x><c-n>"

" ---------------
" Neocachecompl
" ---------------
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_auto_select=1 "Select the first entry automatically
let g:neocomplcache_enable_cursor_hold_i=1
let g:neocomplcache_cursor_hold_i_time=300
let g:neocomplcache_auto_completion_start_length=1

" -----------------
" manpageview
" -----------------
let g:manpageview_winopen="hsplit="

" -----------------
" LaTeX-suite
" -----------------
set grepprg=grep\ -nH\ $*
"call IMAP('EFM', '\begin{frame}    \frametitle{}\end{frame}', 'tex')
"au filetype tex imap <buffer> <M-TAB> <Plug>Tex_Completion

" -----------------
" NERD commenter
" -----------------
let NERDShutUp = 1

" -----------------
" Haskell mode
" -----------------
" use ghc functionality for haskell files
autocmd filetype haskell set ts=4
au Bufenter *.hs compiler ghc
let g:haskell_indent_if=4

" -----------------
" ZenCoding
" -----------------
let g:use_zen_complete_tag=1
let g:user_zen_expandabbr_key='<c-j>'

" -----------------
" taglist
" -----------------
nnoremap <silent> <F4> :TlistToggle<CR>
let g:Tlist_Show_One_File=1
let g:Tlist_Use_Right_Window=1
let g:Tlist_Exit_OnlyWindow=1
let g:Tlist_Inc_Winwidth=1

" -----------------
" status
" -----------------
let g:statusline_fugitive = 1
let g:statusline_rvm=0
let g:statusline_syntastic=0
let g:statusline_enabled=1
let g:statusline_fullpath=0

" Everything must be after Right Separator for BufStat
let g:statusline_order=[
      \ 'Filename',
      \ 'Encoding',
      \ 'Help',
      \ 'Filetype',
      \ 'Modified',
      \ 'Fugitive',
      \ 'RVM',
      \ 'TabWarning',
      \ 'Syntastic',
      \ 'Paste',
      \ 'ReadOnly',
      \ 'RightSeperator',
      \ 'CurrentHighlight',
      \ 'CursorColumn',
      \ 'LineAndTotal',
      \ 'FilePercent']

" -----------------
" FuzzyFinder
" -----------------
let g:fuf_modesDisable=['mrucmd'] " Enables FufMruFile
"nnoremap <C-s> :FufBuffer<CR>
nnoremap <silent>s<C-s> :FufFileWithCurrentBufferDir<CR>
nnoremap <silent><C-y> :FufMruFile<CR>
nnoremap <Leader>ff :FufFile<CR>
nnoremap <Leader>fm :FufMruFile<CR>

" ---------------
" Session
" ---------------
let g:session_autosave=1
let g:session_autoload=0
nnoremap <Leader>os :OpenSession<CR>

" ---------------
" Vundle
" ---------------
nmap <Leader>bi :BundleInstall<CR>
nmap <Leader>bi! :BundleInstall!<CR>
nmap <Leader>bu :BundleInstall!<CR> " Because this also updates
nmap <Leader>bc :BundleClean<CR>

" ---------------
" Kwbd
" ---------------
nnoremap <Leader>d :Kwbd<CR>

" ---------------
" Syntastic
" ---------------

let g:syntastic_mode_map={ 'mode': 'passive',
                         \ 'active_filetypes': ['ruby', 'python'],
                         \ 'passive_filetypes': ['c'] }

" ---------------
" Syntastic
" ---------------

let g:EasyMotion_mapping_f='f'
let g:EasyMotion_mapping_F='F'

set exrc
set secure
