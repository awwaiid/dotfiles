function! InsertTabWrapper(direction)
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    elseif "backward" == a:direction
        return "\<c-p>"
    else
        return "\<c-n>"
    endif
endfunction

"inoremap <tab> <c-r>=InsertTabWrapper ("backward")<cr>
inoremap <tab> <c-r>=pumvisible() ? "\<lt>c-e>\<lt>c-n>" : InsertTabWrapper ("backward")<cr>

inoremap <s-tab> <c-r>=InsertTabWrapper ("forward")<cr>


