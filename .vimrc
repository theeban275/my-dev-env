set nocompatible
scriptencoding utf-8

" Vundle Plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-fugitive'
" TODO vim-surround, vim-repeat, ack.vim, nerdtree, commentary
Plugin 'lifepillar/vim-solarized8'
call vundle#end()

" Functions
silent function! OSX()
    return has('macunix')
endfunction

silent function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction

" TODO add function to check if using gui version of vim

function! s:Preserve(command)
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    execute a:command
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction

" Editor Settings

let mapleader=","

" nice tab behavior
set ts=4 sts=4 sw=4 expandtab

" invisible characters
nnoremap <leader>l :set list!<CR>

" search
set hlsearch

if has("autocmd")
    augroup vimrc
        autocmd!
        " strip trailing whitespaces on save
        autocmd BufWritePre * :call s:Preserve("%s/\\s\\+$//e")

        " TODO add trailing line space if it doesn't exist
    augroup END
endif

" TODO set font and font size when using gui version of vim

" editing vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" easier splits
set splitbelow
set splitright

command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <C-W>a :ZoomToggle<CR>

" TODO add undo history and branches

" theme
if filereadable(expand("$HOME/.vim/bundle/vim-solarized8/colors/solarized8.vim"))
    set termguicolors " enable true color support
    set background=dark
    colorscheme solarized8
endif

