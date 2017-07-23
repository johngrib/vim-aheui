scriptencoding utf-8

let s:util = {}
let s:target_file = ''

let s:rawCode = ''
let s:codeList = []
let s:code = []
let s:pointer = {}
let s:memory = {}
let s:functions = {}
let s:position = {}
let s:breakPoint = []
let s:step_started = 0

function! s:initialize()
    let s:step_started = 1
    let s:target_file = @%
    let s:util = s:getUtil()
    let s:rawCode = s:util.getCodeOnCursor()
    let s:codeList = s:util.getCodeList(s:rawCode)
    let s:position = s:getStartPosition()
    let s:code = s:util.getDividedCode(s:codeList)
    let s:pointer = VimAheui#pointer#new(s:code)
    let s:memory = VimAheui#memory#new()
    let s:functions = VimAheui#functions#new()
    call VimAheui#printbuffer#clear()
    call s:setBreakPoint()
    let s:start_time = reltime()
endfunction

function! s:close(isGetValue)
    let s:step_started = 0
    let l:seconds = reltimefloat(reltime(s:start_time))
    if a:isGetValue
        return VimAheui#printbuffer#get()
    endif
    call VimAheui#printbuffer#pushStr(s:getElapsedTimeStr(l:seconds))
    call VimAheui#console#open()
endfunction

function! s:getStartPosition()
    let l:pos = getpos("'.")
    let l:obj = {}
    let l:obj.buffer = l:pos[0]
    let l:obj.line = 1
    let l:obj.col = 1
    return l:obj
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

function! VimAheui#debugger#run(ignoreBreak, isGetValue)

    if ! s:isDebugStarted()
        call s:initialize()
    endif

    let l:cmd = s:getCommand(s:pointer)

    while v:true

        let Cfunc = s:functions.get(l:cmd)
        let l:cmd = Cfunc(l:cmd, s:memory)

        if l:cmd.cho == 'ㅎ'
            return s:close(a:isGetValue)
        endif

        let s:pointer = s:pointer.step(l:cmd)
        let l:cmd = s:getCommand(s:pointer)

        if a:ignoreBreak == 0 && l:cmd.break != 0
            call s:moveCursor()
            call VimAheui#inspector#open()
            break
        endif

    endwhile

endfunction

function! s:getElapsedTimeStr(time)
    return "\nelapsed time: " . string(a:time) . ' sec'
endfunction

function! VimAheui#debugger#step()

    if ! s:isDebugStarted()
        call s:initialize()
    endif

    let l:cmd = s:getCommand(s:pointer)
    let Cfunc = s:functions.get(l:cmd)
    let l:cmd = Cfunc(l:cmd, s:memory)

    if l:cmd.cho == 'ㅎ'
        call s:close()
        return
    endif

    let s:pointer = s:pointer.step(l:cmd)
    call s:moveCursor()
    call VimAheui#inspector#open()

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

