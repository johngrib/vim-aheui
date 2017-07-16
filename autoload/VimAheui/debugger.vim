scriptencoding utf-8

let s:util = {}

let s:rawCode = ''
let s:codeList = []
let s:code = []

let s:directionMap = {}

let s:pointer = {'x':0, 'y':0}
let s:pointer.direction = {'x':0, 'y':0}
let s:pointer.old = {'x':0, 'y':0}

function! VimAheui#debugger#run()

    call s:init()

    while v:true

        let l:cmd = s:getCommand()

        echom string(l:cmd)

        try
            call s:movePointer(l:cmd)
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

function! s:init()

    let s:util = s:getUtil()

    let s:rawCode = s:util.getCodeOnCursor()
    let s:codeList = s:util.getCodeList(s:rawCode)
    let s:code = s:util.getDividedCode(s:codeList)

    let s:directionMap = s:setDirectionMap()
    let s:pointer = VimAheui#pointer#new()

endfunction

function! s:getCommand()
    return s:code[(s:pointer.y)][(s:pointer.x)]
endfunction

function! s:movePointer(cmd)
    call s:directionMap[a:cmd[1]]()
endfunction

function! s:moveBack()
    let l:temp = {'x':(s:pointer.x), 'y':(s:pointer.y)}
    let s:pointer.x = s:pointer.old.x
    let s:pointer.y = s:pointer.old.y
    let s:pointer.old = l:temp
endfunction

function! s:setDirectionMap()

    if ! empty(s:directionMap)
        return s:directionMap
    endif

    let l:dir = {}
    let l:dir['ㅏ'] = function('<SID>right', [1])
    let l:dir['ㅑ'] = function('<SID>right', [2])

    let l:dir['ㅓ'] = function('<SID>right', [-1])
    let l:dir['ㅕ'] = function('<SID>right', [-2])

    let l:dir['ㅗ'] = function('<SID>down', [-1])
    let l:dir['ㅛ'] = function('<SID>down', [-2])

    let l:dir['ㅜ'] = function('<SID>down', [1])
    let l:dir['ㅠ'] = function('<SID>down', [2])

    let l:dir['ㅡ'] = function('<SID>horizon')
    let l:dir['ㅣ'] = function('<SID>vertical')
    let l:dir['ㅢ'] = function('<SID>reflect')

    let l:dir['ㅐ'] = function('<SID>go')
    let l:dir['ㅔ'] = function('<SID>go')
    let l:dir['ㅒ'] = function('<SID>go')
    let l:dir['ㅖ'] = function('<SID>go')
    let l:dir['ㅘ'] = function('<SID>go')
    let l:dir['ㅚ'] = function('<SID>go')
    let l:dir['ㅝ'] = function('<SID>go')
    let l:dir['ㅞ'] = function('<SID>go')
    let l:dir['ㅟ'] = function('<SID>go')

    return l:dir

endfunction

function s:right(m)
    let s:pointer.direction.x = a:m
    let s:pointer.direction.y = 0
    call s:pointer.move()
endfunction

function s:down(m)
    let s:pointer.direction.x = 0
    let s:pointer.direction.y = a:m
    call s:pointer.move()
endfunction

function s:go()
    call s:pointer.move()
endfunction

function s:goBack()
    call s:moveBack()
endfunction

function s:reverseX()
    let s:pointer.direction.x *= -1
endfunction

function s:reverseY()
    let s:pointer.direction.y *= -1
endfunction

function s:horizon()
    if s:pointer.y == s:pointer.old.y
        call s:go()
    else
        call s:goBack()
        call s:reverseX()
    endif
endfunction

function s:vertical()
    if s:pointer.x == s:pointer.old.x
        call s:go()
    else
        call s:goBack()
        call s:reverseY()
    endif
endfunction

function s:reflect()
    call s:goBack()
    call s:reverseX()
    call s:reverseY()
endfunction

