scriptencoding utf-8

let s:buffer_name = '* VIM AHEUI MEMORY INSPECTOR *'

function! VimAheui#inspector#open()

    let l:edit_buffer = @%

    if bufexists(s:buffer_name)
        call s:activateBuffer(s:buffer_name)
    else
        call s:createNewBuffer()
    endif

    let l:text = VimAheui#debugger#getMemoryStr()

    call s:writeBuffer(l:text)
    call s:activateBuffer(l:edit_buffer)

endfunction

function! VimAheui#inspector#close()
    if bufexists(s:buffer_name)
        call s:activateBuffer(s:buffer_name)
        silent! bdelete!
    endif
endfunction

function! s:writeBuffer(text)
    execute 'normal! ggdG'
    call setline(line('$'), a:text)
    execute 'normal! Gzb'
endfunction

function! s:createNewBuffer()
    silent! execute 'vertical botright 40new ' . s:buffer_name
    call s:setInit()
endfunction

function! s:setInit()
    setlocal bufhidden=wipe
    setlocal buftype=nofile
    " setlocal buftype=nowrite
    setlocal noswapfile
    " setlocal nowrap
    setlocal fileencodings=utf-8
    setlocal lazyredraw
    setlocal nofoldenable
endfunction

function! s:activateBuffer(buffer_name)
    let window = bufwinnr(a:buffer_name)
    if window == -1
        execute 'sbuffer ' . bufnr(s:buffer_name)
        wincmd J
    else
        execute window . 'wincmd w'
    endif
endfunction
