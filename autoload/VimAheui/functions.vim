scriptencoding utf-8

function! VimAheui#functions#new()
    let l:func = {}
    let l:func['ㅇ'] = function('<SID>doNothing')   " 12615
    let l:func['ㅎ'] = function('<SID>end')         " 12622
    let l:func['ㄷ'] = function('<SID>add')         " 12599
    let l:func['ㄸ'] = function('<SID>mul')         " 12600
    let l:func['ㅌ'] = function('<SID>sub')         " 12620
    let l:func['ㄴ'] = function('<SID>div')         " 12596
    let l:func['ㄹ'] = function('<SID>mod')         " 12601
    let l:func['ㅁ'] = function('<SID>pop')         " 12609
    let l:func['ㅂ'] = function('<SID>push')        " 12610
    let l:func['ㅃ'] = function('<SID>dup')         " 12611
    let l:func['ㅍ'] = function('<SID>swap')        " 12621
    let l:func['ㅅ'] = function('<SID>select')      " 12613
    let l:func['ㅆ'] = function('<SID>move')        " 12614
    let l:func['ㅈ'] = function('<SID>compare')     " 12616
    let l:func['ㅊ'] = function('<SID>condition')   " 12618
    let l:func.get = function('<SID>get')
    return l:func
endfunction

function! s:get(cmd) dict
    let l:cho = a:cmd[0]
    if has_key(self, l:cho)
        return self[(l:cho)]
    endif
    throw l:cho . ' function is not exists'
endfunction

function! s:doNothing(cmd, memory)
endfunction

function! s:add(cmd, memory)
endfunction

function! s:mul(cmd, memory)
endfunction

function! s:end(cmd, memory)
endfunction

function! s:sub(cmd, memory)
endfunction

function! s:div(cmd, memory)
endfunction

function! s:mod(cmd, memory)
endfunction

function! s:pop(cmd, memory)
    " print
endfunction

function! s:push(cmd, memory)
endfunction

function! s:dup(cmd, memory)
endfunction

function! s:swap(cmd, memory)
endfunction

function! s:select(cmd, memory)
endfunction

function! s:move(cmd, memory)
endfunction

function! s:compare(cmd, memory)
endfunction

function! s:condition(cmd, memory)
endfunction
