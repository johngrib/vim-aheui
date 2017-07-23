scriptencoding utf-8

let s:text = ['']

function! VimAheui#printbuffer#get()
    return s:text
endfunction

function! VimAheui#printbuffer#push(char)
    if a:char =~ "\n"
        call add(s:text, '')
    else
        let s:text[-1] .= a:char
    endif
endfunction

function! VimAheui#printbuffer#pushStr(str)
    let s:text += split(a:str, "\n", 1)
endfunction

function! VimAheui#printbuffer#pop()
    let l:strList = s:text
    let s:text = ['']
    return l:strList
endfunction

function! VimAheui#printbuffer#clear()
    let s:text = ['']
endfunction
