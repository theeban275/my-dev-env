set nocompatible

" Vundle Plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'lifepillar/vim-solarized8'
call vundle#end()

" Functions
silent function! OSX()
    return has('macunix')
endfunction

silent function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction

function! Preserve(command)
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    execute a:command
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction ndfunction

" Editor Settings
scriptencoding utf-8
filetype plugin indent on
syntax on

let mapleader=","

set ts=4 sts=4 sw=4 expandtab
set backspace=indent,eol,start
set listchars=tab:▸\ ,eol:¬

if has("autocmd")
    augroup vimrc
        autocmd!
        " strip trailing whitespaces on save
        autocmd BufWritePre * :call Preserve("%s/\\s\\+$//e")
    augroup END
endif

set termguicolors " enable true color support
set background=dark
colorscheme solarized8

" Mappings

nnoremap <leader>l :set list!<CR>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

