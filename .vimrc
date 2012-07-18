
" My Very Own .vimrc
" Brock Wilcox (awwaiid@thelackthereof.org)

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

" Save undo stuff in this directory (instead of local)
set undofile
set undodir=~/.vim_undo//,.,~/tmp,~/

" Save ~ files to this global shared dir if possible
set backup
set backupdir=~/.vim_backup//,.,~/tmp,~/
set dir=~/.vim_backup//,.,~/tmp,~/

" Add nested star lists to comments, good for wiki editing
set comments+=:******,:*****,:****,:***,:**

" Not too likely I'll want to edit these files, so skip tab-complete
set wildignore+=*.jpg,*.png,*.gif,*.pdf,_darcs,blib,_build,.gz,.bz2,.bak,cpan

" status line: filename(flags) filetype row, col cur% file-lines
set statusline=%f%m%r%h%w\ %y\ %=%l,%c\ %p%%\ %L
hi  statusline term=NONE cterm=NONE ctermfg=magenta ctermbg=NONE
set laststatus=2

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
endif

"  stuff defaults to darkblue which is unreadable
hi PreProc ctermfg=lightyellow

" And nice grey comments
" set t_Co=88
set t_Co=256
"hi Comment ctermfg=59
hi Comment ctermfg=8

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
iab Ydtime <c-r>=strftime("%Y.%m.%d.%H.%M")<cr>
iab Ydate <c-r>=strftime("%Y.%m.%d")<cr>
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
" nnoremap <silent> <F6> :set invnumber invcursorline invcursorcolumn<cr>
nnoremap <silent> <F6> :set invnumber invcursorline<cr>
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
com! Preview :w | !~/bin/mdoc '%' ; acroread '%<.pdf'

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


" *********************************
" ******** PLUGIN SETTINGS ********
" *********************************

" Pathogen! Loads stuff better.
call pathogen#infect()

" Enhanced Commentify
let g:EnhCommentifyRespectIndent = 'Yes'
let g:EnhCommentifyUseAltKeys = 'No'
let g:EnhCommentifyFirstLineMode = 'Yes'
let g:EnhCommentifyMultiPartBlocks = 'Yes'
let g:EnhCommentifyPretty = 'Yes'


" Command-T: Fix up current selection highlight color
hi CommandTSelection term=NONE cterm=NONE ctermfg=white ctermbg=59

" Command-T: Fix up-arrow, left-arrow, and backspace
let g:CommandTSelectPrevMap=['<C-p>','<C-k>','<Esc>0A','<Up>']
let g:CommandTCursorLeftMap=['<Left>']
let g:CommandTBackspaceMap=['<BS>', '<C-h>']

" Command-T: Use ctrl-t for command-t!
nmap <silent> <C-t> :CommandT<CR>
nmap <silent> <C-b> :CommandTBuffer<CR>

" Command-T: Keep the results at the top to save eyeball focus
let g:CommandTMatchWindowAtTop=1

" LOTS OF FILES
let g:CommandTMaxFiles=100000

" Tagbar
nnoremap <F1> :TagbarToggle<cr>
nnoremap <silent> <C-g> :TagbarOpenAutoClose<cr>

" Toggle a nice undo-tree 
nnoremap <F3> :GundoToggle<CR>

" ****************************************
" ******** HOST SPECIFIC SETTINGS ********
" ****************************************

" Working at LSI ... they like tabs
if ($HOSTNAME == "wickedwitch")
  set sw=2                " Width to shift and indent things
  set ts=2                " Set tabsize to 2 (to view other people's crap)
  set noet                " Use tabs. Even though tabs are the devil.
  match errorMsg /[^\t]\zs\t\+/

	" Run the failing tests
	nnoremap <silent> <F10> :w \| :silent ! bin/test_suite.pl failing >> tests.log 2>&1 &<cr>
	imap <F10> <C-O><F10>
endif


" *****************************************
" ******** TOO LAZY TO MAKE PLUGIN ********
" *****************************************

" From http://use.perl.org/~Ovid/journal/36929
" By Ovid

function! GotoSub(subname)
  let files  = []

  " find paths to modules with that sub
  let paths = split(system("ack --perl -l 'sub\\s+".a:subname."' lib"), "\n")

  if empty(paths)
      echomsg("Subroutine '".a:subname."' not found")
  else
      let file = PickFromList('file', paths)
      execute "edit " . file

      " jump to where that sub is defined
      execute "/sub\\s\\+"  . a:subname . "\\>"
  endif
endfunction

" Of course, you might wonder what that "pick from list" is. I keep needing to
" either let a user select from a list of choices (usually file names) or just
" return the one damned choice if there is only one.

function! PickFromList( name, list, ... )
    let forcelist = a:0 && a:1 ? 1 : 0

    if 1 == len(a:list) && !forcelist
        let choice = 0
    else
        let lines = [ 'Choose a '. a:name . ':' ]
            \ + map(range(1, len(a:list)), 'v:val .": ". a:list[v:val - 1]')
        let choice  = inputlist(lines)
        if choice > 0 && choice <= len(a:list)
            let choice = choice - 1
        else
            let choice = choice - 1
        endif
    end

    return a:list[choice]
endfunction

" And the actual mapping is simple:
noremap  ,gs  :call GotoSub(expand('<cword>'))<cr>



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

" Presentation mode
" syntax off
" set t_Co=88
" hi Comment ctermfg=85

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

