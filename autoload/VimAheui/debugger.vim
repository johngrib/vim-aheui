scriptencoding utf-8

let s:util = {}

let s:rawCode = ''
let s:codeList = []
let s:code = []
let s:pointer = {}
let s:memory = {}
let s:functions = {}

function! s:init()
    let s:util = s:getUtil()
    let s:rawCode = s:util.getCodeOnCursor()
    let s:codeList = s:util.getCodeList(s:rawCode)
    let s:code = s:util.getDividedCode(s:codeList)
    let s:pointer = VimAheui#pointer#new()
    let s:memory = VimAheui#memory#new()
    let s:functions = VimAheui#functions#new()
endfunction

function! VimAheui#debugger#run()

    call s:init()

    while v:true

        let l:cmd = s:getCommand(s:pointer)

        try
            let Cfunc = s:functions.get(l:cmd)
            let l:cmd = Cfunc(l:cmd, s:memory)

            if l:cmd[0] == 'ㅎ'
                break
            endif

            let s:pointer = s:pointer.step(l:cmd)
        catch
            echom v:errmsg
            break
        endtry

    endwhile

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

