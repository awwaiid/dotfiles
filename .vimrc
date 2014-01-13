
" My Very Own .vimrc
" Brock Wilcox (awwaiid@thelackthereof.org)

" Pathogen! Loads stuff better. Load this early!
call pathogen#infect()


" **********************************
" ******** GENERAL SETTINGS ********
" **********************************

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

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
set cm=blowfish         " Set a worthwhile encryption method
set nofoldenable        " Turn off folding
set formatoptions+=r    " Insert comment-header on enter (auto-comment)
set formatoptions+=o    " Insert comment-header on 'o'
set formatoptions+=q    " Format comments with gq
set formatoptions+=c    " For most things don't auto-break comments
set cpoptions+=n        " Include line-wrap indicator in number column
let mapleader=","       " Use ',' as the Leader

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
map <c-f> gggqG " ^F = format whole document
map f gqap      " f = format this paragraph

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
nnoremap <silent> <F8> :set invpaste paste?<cr>
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
vmap ,ga :<C-U>!hg annotate -udqc % \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" Experimental use of shift-arrow to jump between braces
map <c-left> [{
imap <c-left> <c-o>[{
map <c-right> ]}
imap <c-right> <c-o>]}

" Control-tab for omni-complete
imap <c-tab> <c-x><c-o>

" Fix common mistakes
iab BRock Brock


" ********************************************
" ******** FILETYPE SPECIFIC SETTINGS ********
" ********************************************

" Turn on default filetype-specific plugin defaults
filetype plugin on

" Auto-break paragraphs (don't be scared -- this is OK)
" au FileType tex set formatoptions+=a
" au FileType tex set formatoptions+=t " For TeX documents auto-break everything
au FileType tex set formatoptions-=c " For TeX documents auto-break everything

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


" Command-T
" ---------
" Fix up current selection highlight color
hi CommandTSelection term=NONE cterm=NONE ctermfg=white ctermbg=59

" Fix up-arrow, left-arrow, and backspace
let g:CommandTSelectPrevMap=['<C-p>','<C-k>','<Esc>0A','<Up>']
let g:CommandTCursorLeftMap=['<Left>']
let g:CommandTBackspaceMap=['<BS>', '<C-h>']

" Use ctrl-t for command-t!
" nmap <silent> <C-t> :CommandT<CR>

" Narrow the search to just the current buffers
" nmap <silent> <C-b> :CommandTBuffer<CR>

" Keep the results at the top to save eyeball focus
let g:CommandTMatchWindowAtTop=1

" LOTS OF FILES
let g:CommandTMaxFiles=100000


" Syntastic!
" ----------
"au FileType perl SyntasticEnable
let g:syntastic_enable_signs=1
set statusline+=%{SyntasticStatuslineFlag()}
" Only care about errors... warnings my eye!
let g:syntastic_quiet_warnings=1

" Auto-open/close error window
let g:syntastic_auto_loc_list=1 " or 2 for only auto-close

" OK, syntastic is annoying. Disable it by default.
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': [] }


" Tagbar
" ------
" nnoremap <F1> :TagbarToggle<cr>
nnoremap <silent> <C-g> :TagbarOpenAutoClose<cr>
let g:tagbar_sort = 0


" Undo-Tree
" ---------
nnoremap <F3> :UndotreeToggle<CR>
nnoremap <C-u> :UndotreeToggle<CR>
let g:undotree_SplitLocation = 'botright'
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_HighlightSyntax = "cursorline"


" Ctrl-P (Alternative to Command-T)
" ---------------------------------
" hi CtrlPPrtCursor term=NONE cterm=NONE ctermfg=white ctermbg=59
hi CtrlPLinePre term=NONE cterm=NONE ctermfg=white ctermbg=59
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_max_height = 100
let g:ctrlp_max_files = 100000
let g:ctrlp_map = '<c-t>'
let g:ctrlp_working_path_mode = ''
nmap <silent> <C-b> :CtrlPBuffer<CR>
nmap <silent> <C-l> :CtrlPLineAll<CR>


" GitGutter (show how file has changed in realtime)
" -------------------------------------------------
let g:gitgutter_enabled = 0


" Fireplace / Overtone
" --------------------
nnoremap <F1> :Eval (stop)<cr>


" ****************************************
" ******** HOST SPECIFIC SETTINGS ********
" ****************************************

" ... none for now!


" *****************************************
" ******** TOO LAZY TO MAKE PLUGIN ********
" *****************************************

" From http://www.ibm.com/developerworks/linux/library/l-vim-script-4/index.html
function! AlignAssignments ()
    "Patterns needed to locate assignment operators...
    let ASSIGN_OP   = '[-+*/%|&]\?=\@<!=[=~]\@!'
    let ASSIGN_LINE = '^\(.\{-}\)\s*\(' . ASSIGN_OP . '\)'

    "Locate block of code to be considered (same indentation, no blanks)
    let indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
    let firstline  = search('^\%('. indent_pat . '\)\@!','bnW') + 1
    let lastline   = search('^\%('. indent_pat . '\)\@!', 'nW') - 1
    if lastline < 0
        let lastline = line('$')
    endif

    "Find the column at which the operators should be aligned...
    let max_align_col = 0
    let max_op_width  = 0
    for linetext in getline(firstline, lastline)
        "Does this line have an assignment in it?
        let left_width = match(linetext, '\s*' . ASSIGN_OP)

        "If so, track the maximal assignment column and operator width...
        if left_width >= 0
            let max_align_col = max([max_align_col, left_width])

            let op_width      = strlen(matchstr(linetext, ASSIGN_OP))
            let max_op_width  = max([max_op_width, op_width+1])
         endif
    endfor

    "Code needed to reformat lines so as to align operators...
    let FORMATTER = '\=printf("%-*s%*s", max_align_col, submatch(1),
    \                                    max_op_width,  submatch(2))'

    " Reformat lines with operators aligned in the appropriate column...
    for linenum in range(firstline, lastline)
        let oldline = getline(linenum)
        let newline = substitute(oldline, ASSIGN_LINE, FORMATTER, "")
        call setline(linenum, newline)
    endfor
endfunction

nmap <silent>  ;=  :call AlignAssignments()<CR>


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

