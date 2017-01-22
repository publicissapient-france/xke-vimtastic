set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-sensible'
Plugin 'flazz/vim-colorschemes'
Plugin 'Lokaltog/vim-powerline'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'moll/vim-node'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'pangloss/vim-javascript'
Plugin 'editorconfig/editorconfig-vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
syntax on

let mapleader=","
noremap \ ,

color Tomorrow-Night-Eighties

set cursorline
set expandtab
set modelines=0
set shiftwidth=2
set clipboard=unnamed
set synmaxcol=128
set ttyscroll=10
set encoding=utf-8
set tabstop=2
set nowrap
set expandtab
set nowritebackup
set noswapfile
set nobackup
set hlsearch
set ignorecase
set smartcase
set relativenumber

" folding
set foldcolumn=4
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Vertical diffs
set diffopt+=vertical

" Jump to the next row on long lines
map <Down> gj
map <Up>   gk
nnoremap j gj
nnoremap k gk

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

noremap H ^
noremap L $

" Move multiple lines
nnoremap <c-s-j> :m .+1<CR>==
nnoremap <c-s-k> :m .-2<CR>==
inoremap <c-s-j> <Esc>:m .+1<CR>==gi
inoremap <c-s-k> <Esc>:m .-2<CR>==gi
vnoremap <c-s-j> :m '>+1<CR>gv=gv
vnoremap <c-s-k> :m '<-2<CR>gv=gv

nnoremap <c-s-down> :m .+1<CR>==
nnoremap <c-s-up> :m .-2<CR>==
inoremap <c-s-down> <Esc>:m .+1<CR>==gi
inoremap <c-s-up> <Esc>:m .-2<CR>==gi
vnoremap <c-s-down> :m '>+1<CR>gv=gv
vnoremap <c-s-up> :m '<-2<CR>gv=gv

" Tab between buffers
noremap <tab> <c-w><c-w>

" Switch between last two buffers
nnoremap <leader><leader> <C-^>

" NERDTree
nmap <leader>n :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg']
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeGlyphReadOnly = 'r'

" Syntastic
function! SyntasticESlintChecker()
  let l:npm_bin = ''
  let l:eslint = 'eslint'

  if executable('npm')
    let l:npm_bin = split(system('npm bin'), '\n')[0]
  endif

  if strlen(l:npm_bin) && executable(l:npm_bin . '/eslint')
    let l:eslint = l:npm_bin . '/eslint'
  endif

  let b:syntastic_javascript_eslint_exec = l:eslint
endfunction


let g:syntastic_javascript_checkers = ["eslint"]

autocmd FileType javascript :call SyntasticESlintChecker()

function ESLintFix()
  silent execute "!./node_modules/.bin/eslint --fix %"
  edit! %
endfunction

nnoremap <leader>fl :call ESLintFix()<CR>

" CtrlP
nnoremap <silent> t :CtrlP<cr>
let g:ctrlp_working_path_mode = 2
let g:ctrlp_by_filename = 1
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 15
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" JSBeautify
map <c-f> :call JsBeautify()<cr>
" or
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
" for json
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
" for jsx
autocmd FileType javascript.jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

" Open file shortcuts
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
map ,t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map ,s :split <C-R>=expand("%:p:h") . "/" <CR>

" Quit with :Q
command -nargs=0 Quit :qa!
