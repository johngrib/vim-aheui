scriptencoding utf-8

let s:buffer_name = '* VIM AHEUI CONSOLE *'

function! VimAheui#console#open()

    if bufexists(s:buffer_name)
        call s:activateBuffer()
    else
        call s:createNewBuffer()
        let l:text = VimAheui#printbuffer#pop()
        call append(line('$'), '')
        call setline(line('$'), split(l:text, '\n'))
    endif

endfunction

function! s:createNewBuffer()
    execute 'new ' . s:buffer_name
    call s:setInit()
    wincmd J
endfunction

function! s:setInit()
    setlocal bufhidden=wipe
    setlocal buftype=nofile
    setlocal buftype=nowrite
    setlocal noswapfile
    setlocal nowrap
    setlocal laststatus=2
    setlocal fileencodings=utf-8
    setlocal lazyredraw
    setlocal nofoldenable
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
