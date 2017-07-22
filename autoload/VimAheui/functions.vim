scriptencoding utf-8

let s:number = {}

function! VimAheui#functions#new()

    let s:number = VimAheui#number#new()

    let l:func = {}
    let l:func[''] = function('<SID>doNothing')
    let l:func['ㅇ'] = function('<SID>doNothing')
    let l:func['ㅎ'] = function('<SID>end')
    let l:func['ㄷ'] = function('<SID>backStepAble', [function('<SID>add', [], l:func), 2])
    let l:func['ㄸ'] = function('<SID>backStepAble', [function('<SID>mul', [], l:func), 2])
    let l:func['ㅌ'] = function('<SID>backStepAble', [function('<SID>sub', [], l:func), 2])
    let l:func['ㄴ'] = function('<SID>backStepAble', [function('<SID>div', [], l:func), 2])
    let l:func['ㄹ'] = function('<SID>backStepAble', [function('<SID>mod', [], l:func), 2])
    let l:func['ㅁ'] = function('<SID>backStepAble', [function('<SID>pop', [], l:func), 1])
    let l:func['ㅂ'] = function('<SID>push')
    let l:func['ㅃ'] = function('<SID>backStepAble', [function('<SID>dup', [], l:func), 1])
    let l:func['ㅍ'] = function('<SID>backStepAble', [function('<SID>swap', [], l:func), 2])
    let l:func['ㅅ'] = function('<SID>select')
    let l:func['ㅆ'] = function('<SID>backStepAble', [function('<SID>move', [], l:func), 1])
    let l:func['ㅈ'] = function('<SID>backStepAble', [function('<SID>compare', [], l:func), 2])
    let l:func['ㅊ'] = function('<SID>backStepAble', [function('<SID>condition', [], l:func), 1])
    let l:func.get = function('<SID>get')

    let l:func.print = {}
    let l:func.print['ㅇ'] = function('<SID>getNumber')
    let l:func.print['ㅎ'] = function('<SID>getString')

    return l:func
endfunction

function! s:get(cmd) dict
    let l:cho = a:cmd.cho
    if has_key(self, l:cho)
        return self[(l:cho)]
    endif
    throw l:cho . ' function is not exists'
endfunction

function! s:doNothing(cmd, memory)
    return a:cmd
endfunction

function! s:backStepAble(Method, limit, cmd, memory)
    let l:mem = a:memory.getSelected()
    if l:mem.size() < a:limit
        let a:cmd.reverse = 1
        return a:cmd
    endif
    return a:Method(a:cmd, a:memory)
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
    if has_key(self.print, a:cmd.jong)
        let l:result = self.print[a:cmd.jong](l:v)
        echon l:result
    endif
    return a:cmd
endfunction

function! s:push(cmd, memory)
    let l:mem = a:memory.getSelected()
    let l:num = s:number[(a:cmd.jong)]
    call l:mem.push(l:num)
    return a:cmd
endfunction

function! s:dup(cmd, memory)
    let l:mem = a:memory.getSelected()
    call l:mem.dup()
    return a:cmd
endfunction

function! s:swap(cmd, memory)
    let l:mem = a:memory.getSelected()
    call l:mem.swap()
    return a:cmd
endfunction

function! s:select(cmd, memory)
    let a:memory.selected = a:cmd.jong
    return a:cmd
endfunction

function! s:move(cmd, memory)
    let l:mem = a:memory.getSelected()
    let l:val = l:mem.pop()
    call a:memory.get(a:cmd.jong).push(l:val)
    return a:cmd
endfunction

function! s:compare(cmd, memory)
    let l:mem = a:memory.getSelected()
    let l:a = l:mem.pop()
    let l:b = l:mem.pop()
    if l:b >= l:a
        call l:mem.push(1)
    else
        call l:mem.push(0)
    endif
    return a:cmd
endfunction

function! s:condition(cmd, memory)
    let l:mem = a:memory.getSelected()
    if l:mem.pop() == 0
        let a:cmd.reverse = 1
        return a:cmd
    endif
    return a:cmd
endfunction

function! s:getString(value)
    return nr2char(a:value)
endfunction

function! s:getNumber(value)
    return a:value
endfunction
