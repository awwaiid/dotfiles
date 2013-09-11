" An example for a gvimrc file.
" The commands in this are executed when the GUI is started.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	1999 Feb 02
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.gvimrc
"             for Amiga:  s:.gvimrc
"  for MS-DOS and Win32:  $VIM\_gvimrc

" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty

" set the X11 font to use
" set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1

" set guifont=-Schumacher-Clean-Medium-R-Normal--14-140-75-75-C-70-ISO646.1991-IRV
" set guifont=-misc-fixed-medium-r-normal-*-*-120-*-*-c-*-koi8-r
" set guifont=-bitstream-courier-medium-r-normal-*-*-130-*-*-m-*-iso8859-1
"
"set guifont=-bitstream-courier-bold-r-normal-*-*-130-*-*-m-*-iso8859-1 set
"guifont=-gimpers-drift-medium-r-normal-*-*-100-*-*-m-*-ascii-0
" set guifont="-Misc-Fixed-Medium-R-Normal--14-130-75-75-C-70-ISO8859-1"
"set guifont=-misc-fixed-*-*-*-*-9-*-*-*-*-*-*-*
"set guifont=Fixed\ 9
set guifont=Courier\ 13
"set guifont=-bitstream-courier-medium-r-normal-*-*-130-*-*-m-*-iso8859-1
"set guifont=-schumacher-clean-medium-r-normal-*-*-120-*-*-c-*-iso646.1991-irv

highlight Normal gui=NONE guibg=black guifg=white
highlight Cursor guibg=aquamarine guifg=NONE
highlight NonText gui=NONE guibg=black guifg=red
highlight Search guibg=LightBlue

" Make command line two lines high
set ch=2

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Only do this for Vim version 5.0 and later.
if version >= 500
  set mousehide
endif

" For demos
set guifont=Courier\ New\ 11
set syntax=off
colorscheme desert
let &guicursor = substitute(&guicursor, 'n-v-c:', '&blinkon0-', '')

