scriptencoding utf-8

let s:util = {}

let s:rawCode = ''
let s:codeList = []
let s:code = []
let s:pointer = {}
let s:memory = {}
let s:functions = {}
let s:position = {}

function! s:init()
    let s:util = s:getUtil()
    let s:rawCode = s:util.getCodeOnCursor()
    let s:codeList = s:util.getCodeList(s:rawCode)
    let s:position = s:getStartPosition()
    let s:code = s:util.getDividedCode(s:codeList)
    let s:pointer = VimAheui#pointer#new(s:code)
    let s:memory = VimAheui#memory#new()
    let s:functions = VimAheui#functions#new()
endfunction

function! s:getStartPosition()
    normal! Vip"_y
    let l:pos = getpos("'<")
    let l:obj = {}
    let l:obj.buffer = l:pos[0]
    let l:obj.line = l:pos[1]
    let l:obj.col = l:pos[2]
    return l:obj
endfunction

function! VimAheui#debugger#run()

    call s:init()

    let s:start_time = reltime()

    while v:true

        let l:cmd = s:getCommand(s:pointer)

        try
            let Cfunc = s:functions.get(l:cmd)
            let l:cmd = Cfunc(l:cmd, s:memory)

            if l:cmd.cho == 'ㅎ'
                break
            endif

            let s:pointer = s:pointer.step(l:cmd)
        catch
            echom v:errmsg
            break
        endtry

    endwhile

    let l:seconds = reltimefloat(reltime(s:start_time))

    call VimAheui#printbuffer#push(s:getElapsedTimeStr(l:seconds))
    call VimAheui#console#open()

endfunction

function! s:getElapsedTimeStr(time)
    return "\nelapsed time: " . string(a:time) . ' sec'
endfunction

let s:step_started = 0
function! VimAheui#debugger#step()
    if s:step_started == 1
        let l:cmd = s:getCommand(s:pointer)
        try
            echom string(l:cmd.char)
            let Cfunc = s:functions.get(l:cmd)
            let l:cmd = Cfunc(l:cmd, s:memory)

            if l:cmd.cho == 'ㅎ'
                let s:step_started = 0
                return
            endif

            let s:pointer = s:pointer.step(l:cmd)
            call cursor(s:position.line + s:pointer.y, 1)
            execute 'normal! ' . s:pointer.x . 'l'

        catch
            echom v:errmsg
            let s:step_started = 0
        endtry
    else
        let s:step_started = 1
        call s:init()
        call VimAheui#debugger#step()
    endif
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

