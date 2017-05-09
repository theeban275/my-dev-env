set nocompatible

" Vundle Plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'rking/ag.vim'
Plugin 'mileszs/ack.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'godlygeek/tabular'
call vundle#end()

" Functions
silent function! OSX()
    return has('macunix')
endfunction

silent function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction

" Editor Settings
scriptencoding utf-8
filetype plugin indent on
syntax on

set mouse=a
set mousehide
set backspace=indent,eol,start
set virtualedit=onemore
set hidden
set iskeyword-=.
set iskeyword-=#
set iskeyword-=-
set showmode
set showcmd
set ruler
set number
set showmatch
set incsearch
set hlsearch
set ignorecase
set smartcase
set wildmenu
set wildmode=list:longest,full
set whichwrap=b,s,h,l,<,>,[,]
set scrolljump=5
set scrolloff=3
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
set wrap
set autoindent
set shiftwidth=4
set expandtab
set tabstop=4
set softtabstop=4
set nojoinspaces
set splitright
set splitbelow
set pastetoggle=<F10>

" Key Mappings
noremap Y y$
noremap j gj
noremap k gk
map <S-H> gT
map <S-L> gt
cmap w!! w !sudo tee % >/dev/null
vnoremap > ><CR>gv 
vnoremap < <<CR>gv

" Clipboard Settings
if has('clipboard')
    if has('unnamedplus')   " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else                    " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

" Language Specific Settinjgs
autocmd FileType puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
set re=1 " regular expression engine

" Backup Settings
set backup
if has('persistent_undo')
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

" Commands
function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

command! Strip call StripTrailingWhitespace()

" Misc Settings
let mapleader=','

function! InitializeDirectories()
    let parent = $HOME
    let prefix = 'vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

    let common_dir = parent . '/.' . prefix
    for [dirname, settingname] in items(dir_list)
        let directory = common_dir . dirname . '/'
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction
call InitializeDirectories()

