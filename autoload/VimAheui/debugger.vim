scriptencoding utf-8

let s:util = {}
let s:target_file = ''

let s:codeList = []
let s:code = []
let s:pointer = {}
let s:memory = {}
let s:functions = {}
let s:position = {}
let s:breakPoint = []
let s:step_started = 0

function! VimAheui#debugger#execute(code)

    call s:initialize(a:code)

    let l:cmd = s:getCommand(s:pointer)
    while s:hasNext(l:cmd)
        let l:cmd = s:execute(l:cmd)
        let s:pointer = s:pointer.step(l:cmd)
        let l:cmd = s:getCommand(s:pointer)
    endwhile

    let s:step_started = 0
    return VimAheui#printbuffer#get()
endfunction

function! VimAheui#debugger#run()
    if ! s:isDebugStarted()
        let l:code = VimAheui#util#getCodeOnEditor()
        call s:initialize(l:code)
    endif

    let l:cmd = s:getCommand(s:pointer)

    while s:hasNext(l:cmd)
        let l:cmd = s:execute(l:cmd)
        let s:pointer = s:pointer.step(l:cmd)
        let l:cmd = s:getCommand(s:pointer)
    endwhile
    return s:close()
endfunction

function! VimAheui#debugger#runUntilBreak()
    if ! s:isDebugStarted()
        let l:code = VimAheui#util#getCodeOnEditor()
        call s:initialize(l:code)
    endif

    let Stop = s:procedure('<SID>moveCursor', 'VimAheui#inspector#open')
    let l:cmd = s:getCommand(s:pointer)

    while s:hasNext(l:cmd)

        let l:cmd = s:execute(l:cmd)
        let s:pointer = s:pointer.step(l:cmd)

        if l:cmd.break != 0
            return Stop()
        endif

        let l:cmd = s:getCommand(s:pointer)
    endwhile
    return s:close()
endfunction

function! VimAheui#debugger#step()
    if ! s:isDebugStarted()
        let l:code = VimAheui#util#getCodeOnEditor()
        call s:initialize(l:code)
    endif

    let l:cmd = s:getCommand(s:pointer)
    let l:cmd = s:execute(l:cmd)

    if s:isFinished(l:cmd)
        return s:close()
    endif

    let s:pointer = s:pointer.step(l:cmd)
    call s:moveCursor()
    call VimAheui#inspector#open()
endfunction

function! s:initialize(rawCode)

    let s:step_started = 1
    let s:target_file = @%
    let s:util = s:getUtil()

    let s:position = {'line': 1, 'col': 1}
    let s:codeList = s:util.getCodeList(a:rawCode)
    let s:code = s:util.getDividedCode(s:codeList)
    let s:pointer = VimAheui#pointer#new(s:code)
    let s:memory = VimAheui#memory#new()
    let s:functions = VimAheui#functions#new()
    call VimAheui#printbuffer#clear()
    call s:setBreakPoint()
    let s:start_time = reltime()
endfunction

function! s:close()
    let s:step_started = 0
    let l:seconds = reltimefloat(reltime(s:start_time))
    call VimAheui#printbuffer#pushStr(s:getElapsedTimeStr(l:seconds))
    call VimAheui#console#open()
endfunction

function! VimAheui#debugger#getMemoryStr()
    return s:memory.toStringList()
endfunction

function! s:setBreakPoint()

    let s:breakPoint = []

    for ind in range(97, 122)
        let l:mark = "'" . nr2char(ind)
        let l:pos = getpos(l:mark)
        if l:pos[1] > 0 && l:pos[2] > 0
            let l:col = s:findMultiByteColumn(l:pos[2], l:pos[1])
            call add(s:breakPoint, {'x': (l:col), 'y': (l:pos[1])})
        endif
    endfor

    for point in s:breakPoint
        let s:code[point.y-1][point.x].break = 1
    endfor

endfunction

function! s:findMultiByteColumn(x, y)
    let l:chars = split(getline(a:y), '.\zs')
    let l:sum = 0
    let l:index = 0
    for char in l:chars
        let l:sum += len(char)
        if l:sum >= a:x
            return l:index
        endif
        let l:index += 1
    endfor
    return 0
endfunction

function! s:isDebugStarted()
    return s:step_started == 1 && s:target_file == @%
endfunction


function! s:chain(...)
    for Func in a:000
        call Func()
    endfor
endfunction

function! s:procedure(...)
    let l:func_list = []
    for func_name in a:000
        call add(l:func_list, function(func_name))
    endfor
    return function('<SID>chain', l:func_list)
endfunction

function! s:isFinished(cmd)
    return a:cmd.cho == 'ㅎ'
endfunction

function! s:hasNext(cmd)
    return a:cmd.cho != 'ㅎ'
endfunction

function! s:doNothing()
endfunction

function! s:getElapsedTimeStr(time)
    return "\nelapsed time: " . string(a:time) . ' sec'
endfunction

function! s:execute(cmd)
    let Cfunc = s:functions.get(a:cmd)
    return Cfunc(a:cmd, s:memory)
endfunction

function! s:moveCursor()
    call cursor(s:position.line + s:pointer.y, 1)
    execute 'normal! ' . s:pointer.x . 'l'
endfunction

function! s:getUtil()
    if ! empty(s:util)
        return s:util
    endif
    return VimAheui#util#new()
endfunction

function! s:getCommand(pointer)
    return s:code[(a:pointer.y)][(a:pointer.x)]
endfunction

