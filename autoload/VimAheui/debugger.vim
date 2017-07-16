scriptencoding utf-8

let s:util = {}

let s:rawCode = ''
let s:codeList = []
let s:code = []
let s:pointer = {}

function! s:init()
    let s:util = s:getUtil()
    let s:rawCode = s:util.getCodeOnCursor()
    let s:codeList = s:util.getCodeList(s:rawCode)
    let s:code = s:util.getDividedCode(s:codeList)
    let s:pointer = VimAheui#pointer#new()
endfunction

function! VimAheui#debugger#run()

    call s:init()

    while v:true

        let l:cmd = s:getCommand()

        echom string(l:cmd)

        try
            call s:pointer.step(l:cmd)
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

function! s:getCommand()
    return s:code[(s:pointer.y)][(s:pointer.x)]
endfunction

