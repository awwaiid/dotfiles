
" My Very Own .vimrc
" Brock Wilcox (awwaiid@thelackthereof.org)

" ************************
" ******** VUNDLE ********
" ************************

let has_vundle=1
if !filereadable($HOME."/.vim/bundle/Vundle.vim/README.md")
  echo "Installing Vundle..."
  echo ""
  silent !mkdir -p $HOME/.vim/bundle
  silent !git clone https://github.com/gmarik/Vundle.vim $HOME/.vim/bundle/Vundle.vim
  let has_vundle=0
endif

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'JazzCore/ctrlp-cmatcher'
Plugin 'Pylons/waitress'
Plugin 'Shougo/unite.vim'
Plugin 'TagBar'
Plugin 'Valloric/YouCompleteMe'
Plugin 'airblade/vim-gitgutter'
Plugin 'bewest/argparse'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'closetag.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'davidhalter/jedi'
Plugin 'defnull/bottle'
Plugin 'floobits/floobits-neovim'
Plugin 'gitignore'
Plugin 'gmarik/Vundle.vim'
Plugin 'godlygeek/tabular'
Plugin 'guns/vim-clojure-highlight'
Plugin 'guns/vim-clojure-static'
Plugin 'jasoncodes/ctrlp-modified.vim'
Plugin 'jaxbot/selective-undo.vim'
Plugin 'kana/vim-fakeclip'
Plugin 'kana/vim-textobj-user'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kennethreitz/requests'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'mbbill/undotree'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'nosami/OmniSharpServer'
Plugin 'rking/ag.vim'
Plugin 'ross/requests-futures'
Plugin 'slezica/python-frozendict'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-classpath'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-vinegar'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'matchit.zip'
" Plugin 'tpope/vim-haystack'
" Plugin 'vasconcelloslf/vim-interestingwords'
Plugin 'stefandtw/quickfix-reflector.vim'
" Plugin 'ngmy/vim-rubocop'

call vundle#end()
filetype plugin indent on

" **********************************
" ******** GENERAL SETTINGS ********
" **********************************

" Uhg... nvim doesn't have blowfish
if has('nvim')
else
  set cm=blowfish         " Set a worthwhile encryption method
endif

set nocompatible        " Vim!

set vb                  " I hate the beeping
set aw                  " Auto-write when doing certain things. I added
                        "   this so I could switch buffers more easily.
set sbr=↳\              " Use "↳ " to show line wrapping
set lcs=tab:→⋅,trail:⋅  " Use "→⋅⋅⋅" in 'list' mode to show tabs
set lbr                 " wrap lines to a whole word when convenient
set sw=2                " Width to shift and indent things
set ts=2                " Set tabsize to 4 (to view other people's crap)
set bs=indent,eol,start " allow backspacing over everything in insert mode
set ai                  " always set autoindenting on
set ic smartcase        " Ignore case during searches, unless there is a capital
set et                  " Use spaces, not tabs. tabs are the devil.
set bg=dark             " We are using a dark background
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
                        "   than 50 lines of registers
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set nocindent           " turn off the cindent, just in case it's on
set wildmenu            " Shows possible command completions!
set hlsearch            " Highlight search results
set incsearch           " Incrementally search
set cot=longest,menu    " Complete longest-substring and show a menu
set cpt=.,w,b,u         " During completion, only scan open windows and buffers
set nofoldenable        " Turn off folding
set formatoptions+=r    " Insert comment-header on enter (auto-comment)
set formatoptions+=o    " Insert comment-header on 'o'
set formatoptions+=q    " Format comments with gq
set formatoptions+=c    " For most things don't auto-break comments
set cpoptions+=n        " Include line-wrap indicator in number column
let mapleader=","       " Use ',' as the Leader
set nomodeline          " By default, don't use modelines in files

" Save undo stuff in this directory (instead of local)
set undofile
set undodir=~/.vim_undo//,.,~/tmp,~/

" Save ~ files to this global shared dir if possible
set backup
set backupdir=~/.vim_backup//,.,~/tmp//,~//
set dir=~/.vim_backup//,.,~/tmp//,~//

" Add nested star lists to comments, good for wiki editing
set comments+=:******,:*****,:****,:***,:**
set comments+=:······,:·····,:····,:···,:··,:·

" Not too likely I'll want to edit these files, so skip tab-complete
set wildignore+=*.jpg,*.png,*.gif,*.pdf
set wildignore+=_darcs,.git,.hg
set wildignore+=blib,_build
set wildignore+=*.gz,*.bz2
set wildignore+=*.bak
set wildignore+=cpan
set wildignore+=*.class,*.jar
set wildignore+=*.pyc
set wildignore+=local " don't know about this one...
set wildignore+=*.odt

" status line: filename(flags) filetype row, col cur% file-lines
set statusline=%f%m%r%h%w\ %y\ %=%l,%c\ %p%%\ %L
hi  statusline term=NONE cterm=NONE ctermfg=magenta ctermbg=NONE
set laststatus=2

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
endif

"  stuff defaults to darkblue which is unreadable
" hi PreProc ctermfg=lightyellow

" Lets have a nice little color scheme!
colorscheme Tomorrow-Night-Bright-Trans

" And nice grey comments
" set t_Co=88
set t_Co=256
" hi Comment ctermfg=59
" hi Comment ctermfg=8
hi Comment ctermfg=247

hi CursorLine   cterm=NONE ctermbg=17
hi CursorColumn cterm=NONE ctermbg=17

" Force full syntax sync on all buffers all the time
" autocmd BufEnter * :syntax sync fromstart

" Jump to the previous line we were on when we open a file
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif 


" *******************************************
" ******** KEYBINDINGS AND SHORTCUTS ********
" *******************************************

" I like to insert time stamps - these are macros to do it
iab Ydtime <c-r>=strftime("%Y-%m-%d-%H-%M")<cr>
iab Ydate <c-r>=strftime("%Y-%m-%d")<cr>
iab Yldate <c-r>=strftime("$%Y\\cdot%m\\cdot%d$")<cr>

" Spell checking is usefull for all sorts of things
com! Spellcheck :execute '!aspell -c "%"' | edit
com! GSpellcheck :execute '!gaspell %' | edit " I don't think this works

" For doing english editing hard-wrapping text is nice
" map <c-f> gggqG " ^F = format whole document
" map f gqap      " f = format this paragraph

" For editing I like to move up/down single screen lines (wrapped)
map <up> gk
imap <up> <c-o>gk
map <down> gj
imap <down> <c-o>gj

" Fix insert-mode ctrl-u/w to be undo-able
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Make the up-down arrors select next/prev match during tab-complete
inoremap <up> <C-R>=pumvisible() ? "\<lt>up>" : "\<lt>c-o>gk"<cr>
inoremap <down> <C-R>=pumvisible() ? "\<lt>down>" : "\<lt>c-o>gj"<cr>

" let ctrl-^ work in insert mode too
imap <c-^> <C-O><c-^>

" *** Search shortcuts ***
" Search with very-magic
" nnoremap <F3> /\v


" Turn off current search highlight
nnoremap <silent> <F4> :nohlsearch<cr>

" *** View shortcuts ***
" Show invisible tabs
nnoremap <silent> <F5> :set invlist<cr>
" Show line numbers
nnoremap <silent> <F6> :set invnumber invcursorline \| GitGutterToggle<cr>
" Don't wrap lines
nnoremap <silent> <F7> :set invwrap<cr>
" Toggle paste mode
nnoremap <silent> <F8> :set invpaste!<cr>
set pastetoggle=<F8>


" These F-n keys call out to normal mode from insert mode
imap <F1> <C-O><F1>
imap <F2> <C-O><F2>
imap <F3> <C-O><F3>
imap <F4> <C-O><F4>
imap <F5> <C-O><F5>
imap <F6> <C-O><F6>
imap <F7> <C-O><F7>
imap <F8> <C-O><F8>

" Get the cvs annotation of the highlighted lines
" vmap ,ga :<C-U>!cvs annotate % \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" Get the hg annotation of the highlighted lines
" vmap ,ga :<C-U>!hg annotate -udqc % \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" Get the hg annotation of the highlighted lines
" vmap ,ga :<C-U>!git blame -w % \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
vmap ,ga :<C-U>!git blame -v -L <C-R>=line("'<")<CR>,<C-R>=line("'>")<CR> -e % \| jirablame <CR>

" Experimental use of shift-arrow to jump between braces
map <c-left> [{
imap <c-left> <c-o>[{
map <c-right> ]}
imap <c-right> <c-o>]}

" Control-tab for omni-complete
imap <c-tab> <c-x><c-o>

" Fix common mistakes
iab BRock Brock

" Kill whole words like other places
" inoremap <C-BS> <C-W>
" inoremap  <C-W>

" ********************************************
" ******** FILETYPE SPECIFIC SETTINGS ********
" ********************************************

" Turn on default filetype-specific plugin defaults
filetype plugin on

" Auto-break paragraphs (don't be scared -- this is OK)
" au FileType tex set formatoptions+=a
" au FileType tex set formatoptions+=t " For TeX documents auto-break everything
au FileType tex set formatoptions-=c " For TeX documents auto-break everything

au FileType text set comments=:******,:*****,:****,:***,:**,:*
au FileType text set comments+=:······,:·····,:····,:···,:··,:·

" LaTeX documents are fun, but lets make it even more fun!
" This one write the file and then runs it through mdoc to make ps,pdf,txt,etc
com! Mdoc :w | !~/bin/mdoc '%'
" This one does as above, but then runs gv on the ps
com! Preview :w | silent !~/bin/mdoc '%' ; gnome-open '%:r.pdf'

" Complete things with slases and colons in html mode
au FileType html set isk+=:,/,~
let b:closetag_html_style=1

" Complete things with colons in perl mode (Like Module::)
au FileType perl set isk+=:

" When searching the perl path, include ./ and lib/
let perlpath="lib,."

" Complete things with questionmarks and colons in perl mode (Like Module::)
" au FileType ruby set isk+=:
au FileType ruby set isk+=?

au FileType coffee set isk-=:

" Sometimes I need to tidy up a bit. Only makes sense for HTML.
com! Tidy %!tidy --force-output y -i -wrap 80 --clean y 2>/dev/null

" Fix filetypes when editing email with mutt and turn on spellcheck
au BufNewFile,BufRead
  \ snd.\d\+,.letter,.letter.\d\+,.followup,.article,.article.\d\+,pico.\d\+,
  \mutt-*-\w\+,mutt\w\{6\},ae\d\+.txt,/tmp/SLRN[0-9A-Z.]\+,*.eml
  \ setf text
au BufNewFile,BufRead
  \ snd.\d\+,.letter,.letter.\d\+,.followup,.article,.article.\d\+,pico.\d\+,
  \mutt-*-\w\+,mutt\w\{6\},ae\d\+.txt,/tmp/SLRN[0-9A-Z.]\+,*.eml
  \ set syntax=text spell spelllang=en_us

" Add the filetype for .als Alloy files
au BufRead,BufNewFile *.als setfiletype alloy4


" *********************************
" ******** PLUGIN SETTINGS ********
" *********************************

" Enhanced Commentify
" -------------------
let g:EnhCommentifyRespectIndent = 'Yes'
let g:EnhCommentifyUseAltKeys = 'No'
let g:EnhCommentifyFirstLineMode = 'Yes'
let g:EnhCommentifyMultiPartBlocks = 'Yes'
let g:EnhCommentifyPretty = 'Yes'

" Syntastic!
" ----------
let g:syntastic_enable_signs=1
" set statusline+=%{SyntasticStatuslineFlag()}
" Only care about errors... warnings my eye!
let g:syntastic_quiet_warnings=1

" Auto-open/close error window
let g:syntastic_auto_loc_list=1 " or 2 for only auto-close

" OK, syntastic is annoying. Disable it by default.
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['ruby'],
                           \ 'passive_filetypes': [] }

" Tagbar
" ------
" nnoremap <F1> :TagbarToggle<cr>
nnoremap <silent> <C-g> :TagbarOpenAutoClose<cr>
let g:tagbar_compact = 1
let g:tagbar_width = 60
let g:tagbar_sort = 0
let g:tabgbar_ctags_bin="/usr/local/bin/ctags"
let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 's:states',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }

" Undo-Tree
" ---------
nnoremap <F3> :UndotreeToggle<CR>
nnoremap <C-u> :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_HighlightSyntax = "cursorline"
let g:undotree_WindowLayout = 3


" Ctrl-P (Alternative to Command-T)
" ---------------------------------
" hi CtrlPPrtCursor term=NONE cterm=NONE ctermfg=white ctermbg=59
hi CtrlPLinePre term=NONE cterm=NONE ctermfg=white ctermbg=59
" let g:ctrlp_match_window_bottom = 0
" let g:ctrlp_match_window_reversed = 0
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:100,results:100'
" let g:ctrlp_max_height = 25
" let g:ctrlp_max_files = 1000000
let g:ctrlp_working_path_mode = ''
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_map = '<c-t>'
" let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
  \ 'fallback': 'ag %s -l --nocolor -g ""'
  \ }
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }

" Mappings
nmap <silent> <C-b> :CtrlPBuffer<CR>

" Tabular!
" --------

" ruby new hash syntax
" AddTabularPattern : /\w:\zs/l0l1

" General =, ==, =>
" AddTabularPattern = /^[^=]*\zs=>\?=\?



" GitGutter (show how file has changed in realtime)
" -------------------------------------------------
let g:gitgutter_enabled = 0


" Fireplace / Overtone
" --------------------
nnoremap <F1> :Eval (stop)<cr>

" Rainbow Parenthesis
" -------------------
" let g:rbpt_colorpairs = [
    " \ ['brown',       'RoyalBlue3'],
    " \ ['Darkblue',    'SeaGreen3'],
    " \ ['darkgray',    'DarkOrchid3'],
    " \ ['darkgreen',   'firebrick3'],
    " \ ['darkcyan',    'RoyalBlue3'],
    " \ ['darkred',     'SeaGreen3'],
    " \ ['darkmagenta', 'DarkOrchid3'],
    " \ ['brown',       'firebrick3'],
    " \ ['gray',        'RoyalBlue3'],
    " \ ['black',       'SeaGreen3'],
    " \ ['darkmagenta', 'DarkOrchid3'],
    " \ ['Darkblue',    'firebrick3'],
    " \ ['darkgreen',   'RoyalBlue3'],
    " \ ['darkcyan',    'SeaGreen3'],
    " \ ['darkred',     'DarkOrchid3'],
    " \ ['red',         'firebrick3'],
    " \ ]
let g:rbpt_colorpairs = [
  \ [ '13', '#6c71c4'],
  \ [ '5',  '#d33682'],
  \ [ '1',  '#dc322f'],
  \ [ '9',  '#cb4b16'],
  \ [ '3',  '#b58900'],
  \ [ '2',  '#859900'],
  \ [ '6',  '#2aa198'],
  \ [ '4',  '#268bd2'],
  \ ]

au FileType clojure RainbowParenthesesLoadRound
au FileType clojure RainbowParenthesesLoadSquare
au FileType clojure RainbowParenthesesLoadBraces
au FileType clojure RainbowParenthesesActivate

au FileType lisp RainbowParenthesesLoadRound
au FileType lisp RainbowParenthesesActivate

" ****************************************
" ******** HOST SPECIFIC SETTINGS ********
" ****************************************

" ... none for now!

" ******************************
" ******** RANDOM STUFF ********
" ******************************

" Presentation mode
" syntax off
" set t_Co=88
" hi Comment ctermfg=85

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" TEMPORARY
au FileType java set sw=2                " Width to shift and indent things
au FileType java set ts=2                " Set tabsize to 2 (to view other people's crap)
au FileType java set noet                " Use tabs. Even though tabs are the devil.



  " experimental neovim terminal mappings
  "   if has('nvim') && exists(':tnoremap')
  "       tnoremap <c-h> <c-\><c-n><c-w>h
  "           tnoremap <c-j> <c-\><c-n><c-w>j
  "               tnoremap <c-k> <c-\><c-n><c-w>k
  "                   tnoremap <c-l> <c-\><c-n><c-w>l
  "                       " tnoremap <silent> <c-w>z
  "                       <c-\><c-n>:ZoomWinTabToggle<cr>
  "                           au WinEnter term://* startinsert
  "                             endifèu

" if has('nvim') && exists(':tnoremap')
"   tnoremap <silent> <C-t> <c-\><c-n>:CtrlP<CR>
"   tnoremap <silent> <C-b> <c-\><c-n>:CtrlPBuffer<CR>
"   au WinEnter term://* startinsert
" endif

