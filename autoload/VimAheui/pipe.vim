scriptencoding utf-8

function! VimAheui#pipe#new(name)
    let l:pipe = VimAheui#queue#new(a:name)
    let l:pipe.type = 'Pipe'
endfunction

