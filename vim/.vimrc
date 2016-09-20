" GENERAL SETTINGS:

" Load Pathogen
execute pathogen#infect()

" Save dialog on exit
set confirm

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype plugin indent on

" Enable syntax highlighting
syntax on

" Better command-line completion
set wildmenu
set wildmode=longest:full,full
set completeopt=menuone,longest,preview

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Always display the status line, even if only one window is displayed
set laststatus=2

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
"set cmdheight=2

" Display line numbers on the left
set number

" VIM's 'working directory' is always the same as the file being edited
set autochdir

" Set default textwidth to 80
set tw=80

" Enable backspace at beginning of new line
set backspace=indent,eol,start

" Set default encoding to UTF-8
set encoding=utf-8

" Enable ruler (to show cursor column)
set ruler

" Highligth current line
set cursorline



" TABS:

" Indent amount
set shiftwidth=2

" Display width of tabs
set tabstop=2

" Better tab erasing
set softtabstop=2

" Use spaces instead of tabs
set expandtab



" GUI VS. NO GUI SETINGS:

if has('gui_running')
  " Adjust font face/size
  "set guifont=Monospace\ 9
  " Color theme
  colorscheme github

  " Remove toolbars
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  "set guioptions-=r  "remove right-hand scroll bar
  "set guioptions-=L  "remove left-hand scroll bar

  " Set initial size of GVIM window
  set lines=35 columns=100
else
  set bg=dark
  set mouse=a
endif



" KEY BINDINGS:

" Bind F6 to toggle line wrapping, and enable the horizontal scrollbar when
" entering this mode
"nnoremap <F6> :set invwrap<cr>
nnoremap <silent><expr> <F6> ':set wrap! go'.'-+'[&wrap]."=b\r"

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<cr><C-L>

" Ctrl-N: Open NERDtree
map <C-n> :NERDTreeToggle<CR>

" Close Vim if only opened windows left is NERDtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Open NERDTree in folder of file in active buffer
map <Leader>nt :NERDTree %:p:h<CR>



" VIM-MARKDOWN SETTINGS:

" Disable folding
let g:vim_markdown_folding_disabled=1



" PER FILE TYPE SETTINGS:

autocmd Filetype html setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab tw=600
autocmd Filetype javascript setlocal sw=2 ts=2 sts=2 expandtab
autocmd Filetype tex setlocal sw=2 ts=2 sts=2 expandtab
