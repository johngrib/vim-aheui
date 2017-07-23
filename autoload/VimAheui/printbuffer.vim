scriptencoding utf-8

let s:text = ''

function! VimAheui#printbuffer#get()
    return s:text
endfunction

function! VimAheui#printbuffer#push(str)
    let s:text .= a:str
endfunction

function! VimAheui#printbuffer#pop()
    let l:str = s:text
    let s:text = ''
    return l:str
endfunction

function! VimAheui#printbuffer#clear()
    let s:text = ''
endfunction
