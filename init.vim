"  __  ____   __  _   ___     _____ __  __ ____   ____
" |  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
" | |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
" | |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
" |_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|


" ===
" === Auto load for first time uses
" ===
" if empty(glob('~/.config/nvim/autoload/plug.vim'))
"   silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
"     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif

" ====================
" === Editor Setup ===
" ====================

" ===
" === System
" ===
set clipboard+=unnamed
set mouse=a

" syntax 
syntax on
filetype plugin on
filetype plugin indent on 

" ===
" === Editor behavior
" ===
set number
set cursorline
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set scrolloff=5
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set wrap
set tw=0
set foldmethod=indent
set foldlevel=99
set formatoptions-=tc
set splitright
set splitbelow
set noshowmode
set showcmd
set wildmenu  
set shortmess+=c
set inccommand=split
set novisualbell

set ttyfast "should make scrolling faster
set lazyredraw "same as above

" silent !mkdir -p ~/.config/nvim/tmp/backup
" silent !mkdir -p ~/.config/nvim/tmp/undo
" set backupdir=~/.config/nvim/tmp/backup,.
" set directory=~/.config/nvim/tmp/backup,.

set nobackup
set noswapfile
set history=1000

" search
set ignorecase
set hlsearch
set incsearch

color evening
set t_Co=256
let g:solarized_termcolors=256
let g:solarized_termtrans=1

set background=dark
highlight normal ctermbg=236
highlight cursorline ctermbg=237 ctermfg=white
highlight Pmenu ctermbg=240 ctermfg=white guibg=240 guifg=white
autocmd InsertEnter,InsertLeave * set cul!


" ===
" === Terminal Behavior
" ===
let g:neoterm_autoscroll = 1
"autocmd TermOpen term://* startinsert

map <LEADER>t :set splitbelow<CR>:sp<CR>:term<CR>


" ===
" === Basic Mappings
" ===

"To use `Ctrl+{h,j,k,l}` to navigate windows from any mode:
tnoremap <Esc> <C-\><C-N>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Open the vimrc file anytime
map <LEADER>rc :e ~/AppData/Local/nvim/init.vim<CR>

" ===
" === Cursor Movement
" ===

"faster navigation
noremap <silent> K 3k
noremap <silent> J 3j

noremap <C-p> J

" ===
" === My Snippets
" ===
" source ~/.nvim/snippits.vim



" ===
" === Install Plugins with Vim-Plug
" ===

call plug#begin('~/.nvim/plugged')

Plug 'ShawnChen1996/vim2term'
" File navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" R
Plug 'jalvesaq/Nvim-R'

call plug#end()


" ===================== Start of Plugin Settings =====================
" ===
" === NERDTree
" ===
map tt :NERDTreeToggle<CR>
let NERDTreeMapOpenExpl = ""
let NERDTreeMapUpdir = "N"
let NERDTreeMapUpdirKeepOpen = "n"
let NERDTreeMapOpenSplit = ""
let NERDTreeMapOpenVSplit = "I"
let NERDTreeMapActivateNode = "i"
let NERDTreeMapOpenInTab = "o"
let NERDTreeMapOpenInTabSilent = "O"
let NERDTreeMapPreview = ""
let NERDTreeMapCloseDir = ""
let NERDTreeMapChangeRoot = "l"
let NERDTreeMapMenu = ","
let NERDTreeMapToggleHidden = "zh"

" ===
" === coc
" ===
" fix the most annoying bug that coc has
"autocmd WinEnter * call timer_start(1000, { tid -> execute('unmap if')})
"silent! autocmd BufEnter * silent! call silent! timer_start(600, { tid -> execute('unmap if')})
"silent! autocmd WinEnter * silent! call silent! timer_start(600, { tid -> execute('unmap if')})
silent! au BufEnter * silent! unmap if
"au TextChangedI * GitGutter
" Installing plugins
let g:coc_global_extensions = [
        \ 'coc-python', 'coc-vimlsp', 'coc-snippets', 
        \ 'coc-html', 'coc-r-lsp' ,
        \ 'coc-json', 'coc-css', 'coc-yank']
"
"
"
" use <tab> for trigger completion and navigate to the next complete item
"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"
" Useful commands
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

" ==
" == NVIM-R
" ==
let R_args = ['--no-restore'] 
vmap <C-Enter> <Plug>RESendSelection
nmap <C-Enter> <Plug>RDSendLine
let R_assign = 2  " use ctrl _ _ to enter <-
let R_objbr_opendf = 0

let R_app = "radian"
"let R_cmd = "R"
"let R_hl_term = 0
let R_args = []  " if you had set any
"let R_bracketed_paste = 1


