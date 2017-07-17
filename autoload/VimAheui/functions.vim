scriptencoding utf-8

let s:number = {}

function! VimAheui#functions#new()

    let s:number = VimAheui#number#new()

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

    let l:func.print = {}
    let l:func.print['ㅇ'] = function('<SID>getNumber')
    let l:func.print['ㅎ'] = function('<SID>getString')

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
    return a:cmd
endfunction

function! s:add(cmd, memory)
    let l:mem = a:memory.getSelected()
    let l:res = l:mem.pop() + l:mem.pop()
    call l:mem.push(l:res)
    return a:cmd
endfunction

function! s:mul(cmd, memory)
    let l:mem = a:memory.getSelected()
    let l:res = l:mem.pop() * l:mem.pop()
    call l:mem.push(l:res)
    return a:cmd
endfunction

function! s:end(cmd, memory)
    return a:cmd
endfunction

function! s:sub(cmd, memory)
    let l:mem = a:memory.getSelected()
    let l:a = l:mem.pop()
    let l:b = l:mem.pop()
    call l:mem.push(l:b - l:a)
    return a:cmd
endfunction

function! s:div(cmd, memory)
    let l:mem = a:memory.getSelected()
    let l:a = l:mem.pop()
    let l:b = l:mem.pop()
    call l:mem.push(l:b / l:a)
    return a:cmd
endfunction

function! s:mod(cmd, memory)
    let l:mem = a:memory.getSelected()
    let l:a = l:mem.pop()
    let l:b = l:mem.pop()
    call l:mem.push(l:b % l:a)
    return a:cmd
endfunction

function! s:pop(cmd, memory) dict
    let l:mem = a:memory.getSelected()
    let l:v = l:mem.pop()
    let l:result = self.print[a:cmd[2]](l:v)
    echon l:result
    return a:cmd
endfunction

function! s:push(cmd, memory)
    let l:mem = a:memory.getSelected()
    let l:num = s:number[(a:cmd[2])]
    call l:mem.push(l:num)
    return a:cmd
endfunction

function! s:dup(cmd, memory)
    call a:memory.getSelected().dup()
    return a:cmd
endfunction

function! s:swap(cmd, memory)
    call a:memory.getSelected().swap()
    return a:cmd
endfunction

function! s:select(cmd, memory)
    let a:memory.selected = a:cmd[2]
    return a:cmd
endfunction

function! s:move(cmd, memory)
endfunction

function! s:compare(cmd, memory)
endfunction

function! s:condition(cmd, memory)
endfunction

function! s:getString(value)
    return nr2char(a:value)
endfunction

function! s:getNumber(value)
    return a:value
endfunction
