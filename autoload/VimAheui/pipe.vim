scriptencoding utf-8

function! VimAheui#pipe#new(name)
    return VimAheui#queue#new(a:name)
endfunction

