"   This is the .vimrc file.

" Environment {

    " Identify platform {
        silent function! OSX()
            return has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return  (has('win32') || has('win64'))
        endfunction
    " }

    " Basics {
        set nocompatible        " Must be first line
        if !WINDOWS()
            set shell=/bin/sh
			let g:python3_host_prog = '/usr/bin/python3'
        endif
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if WINDOWS()
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }

    " Arrow Key Fix {
        if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
            inoremap <silent> <C-[>OC <RIGHT>
        endif
    " }

" }

" Use Vundle if available {
    if filereadable(expand("~/.vimrc.plugin"))
         source ~/.vimrc.plugin
    endif
" }

" Use Plug-in Config {
    if filereadable(expand("~/.vimrc.conf"))
         source ~/.vimrc.conf
    endif
" }

" General {

    set background=dark         " Assume a dark background

    " Allow to trigger background
    function! ToggleBG()
        let s:tbg = &background
        " Inversion
        if s:tbg == "dark"
            set background=light
        else
            set background=dark
        endif
    endfunction

    set nu                      " set number
 "   set spell                   " enable spell check
    set ruler                   " Show the ruler
    set magic 			" set reguar expressions
    set showcmd                 " show command line
    set report=0 		" show changes in command windows
    set noerrorbells 		" disable errors bells
    set linespace=0             " No extra spaces between rows
    set viminfo+=! 		" save the golbal arguments
    set showmatch 		" highlight match brackets
    set matchtime=5 		" match time
    set tabpagemax=15           " Only show 15 tabs
    set matchpairs+=<:>         " specially for html
    set scrolloff=10  		" keep 10 line from button
    set hlsearch 		" highlight search
    set nowrapscan 		" search file golbally
    set incsearch 		" searching while input
    set smartcase               " Case sensitive when uc present
    set ignorecase 		" ingored case when search
    set history=300 		" history numbers
    set nocompatible 		" use vim not vi
    set foldmethod=syntax       " use syntax fold
    set foldlevel=100    	" do not fold when startup
    set shortmess=atI 		" disable startup message
    set fillchars=vert:\ ,stl:\ " show space in split
    set mouse=a 		" enable mouse everywhere
    set selection=exclusive     " enable selectmode
    set selectmode=mouse,key    " contain mouse key
    set fileencodings=utf-8,chinese,latin-1 " file encoding
    set nobackup 		" do not backup files
    "set backup                 " backup files
    syntax enable               " syntax enable
    syntax on 			" highlight syntax
    set novisualbell            " disable visual cursor
    set whichwrap=b,s,h,l,<,>,[,]             " Backspace and cursor keys wrap too
    set backspace=indent,eol,start 	      " tell where to delete

" }

" Vim GUI {

    if has("gui_running")
    au GUIEnter * simalt ~x      " auto maximize
    set guioptions-=m
    set guioptions-=T
    set guioptions-=L
    set guioptions-=r
    set guioptions-=b
    endif
    map <silent> <F2> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
	\set guioptions-=r <bar>
        \set guioptions-=l <bar>
        \set guioptions-=b <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
	\set guioptions+=r <bar>
        \set guioptions+=l <bar>
        \set guioptions+=b <bar>
    \endif<CR>

" }

" Formatting {

    " indent foramt
    set autoindent
    set smartindent
    set cindent

    " table format
    set smarttab
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    "set noexpandtab 		" do not use space replace tab
    "set nowrap 		" do not auto-fill

    " file formats
    set fileformats=unix,dos
    "set fileformat=mac

    " set editing enviroment
    "let &termencoding=&encoding
    "set fileencodings=utf-8,gbk,ucs-bom,cp936
    "set fileencoding=gb18030
    "set fileencodings=utf-8,gb18030,utf-16,big5
    set enc=utf-8
    "set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
    "set fileencoding=gb2312

" }

" Key (re)Mappings {

    noremap  <leader>bg :call ToggleBG()<CR>  " change background
    nnoremap <leader>ev :vsplit $MYVIMRC<cr>  " modified config file
    nnoremap <leader>sv :source $MYVIMRC<cr>  " config ctrlpsource file
    :command! -nargs=1 Rename let tpname = expand('%:t') | saveas <args> | edit <args> | call delete(expand(tpname)):w                                   " modified file name
	nnoremap <Leader>st :vsplit term://zsh<CR>" neovim use terminaln
	if has('nvim')
    tnoremap <Esc> <C-\><C-n>
	tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l
    endif

" }

" create file settings{

    autocmd BufNewFile *.cpp,*.cc,*.c,*.hpp,*.h,*.sh,*.py,*.java exec ":call SetTitle()"
    func SetTitle()
    if expand("%:e") == 'sh'
	call setline(1,"\#!/bin/bash")
	call append(line("."), "")
    elseif expand("%:e") == 'py'
    call setline(1,"#!/usr/bin/env python")
    call append(line("."),"# coding=utf-8")
	call append(line(".")+1, "")
    elseif expand("%:e") == 'cpp'
	call setline(1,"#include <iostream.h>")
	call append(line("."), "")
    elseif expand("%:e") == 'cc'
	call setline(1,"#include <iostream.h>")
	call append(line("."), "")
    elseif expand("%:e") == 'c'
	call setline(1,"#include <stdio.h>")
	call append(line("."), "")
    elseif expand("%:e") == 'h'
	call setline(1, "#pragma once")
    elseif expand("%:e") == 'hpp'
	call setline(1, "#pragma once")
    elseif expand("%:e") == 'java'
	call setline(1,"public class ".expand("%:r"))
	call append(line("."),"")
	endif
    endfunc
    autocmd BufNewFile * normal G

" }

" Complie file{

    map <F5> :call CompileRunGcc()<CR>
    imap <F5> <ESC>:call CompileRunGcc()<CR>
    func! CompileRunGcc()
    exec "w"
    exec "cd %:p:h"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!java %<"
    elseif &filetype == 'sh'
        :!./%
    endif
    endfunc
" }
