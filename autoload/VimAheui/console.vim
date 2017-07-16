scriptencoding utf-8

let s:buffer_name = '* VIM AHEUI CONSOLE *'

function! VimAheui#console#open()

    if bufexists(s:buffer_name)
        call s:activateBuffer()
    else
        call s:createNewBuffer()
    endif

endfunction

function! s:createNewBuffer()
    execute 'new ' . s:buffer_name
    wincmd J
endfunction

function! s:activateBuffer()
    let window = bufwinnr(s:buffer_name)
    if window == -1
        execute 'sbuffer ' . bufnr(s:buffer_name)
        wincmd J
    else
        execute window . 'wincmd w'
    endif
endfunction
