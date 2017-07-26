scriptencoding utf-8

function! VimAheui#number#new()
    let l:obj = {}
    let l:obj[''] = function('<SID>getNumber', [0])
    let l:obj['ㄱ'] = function('<SID>getNumber', [2])
    let l:obj['ㄴ'] = function('<SID>getNumber', [2])
    let l:obj['ㄷ'] = function('<SID>getNumber', [3])
    let l:obj['ㄹ'] = function('<SID>getNumber', [5])
    let l:obj['ㅁ'] = function('<SID>getNumber', [4])
    let l:obj['ㅂ'] = function('<SID>getNumber', [4])
    let l:obj['ㅅ'] = function('<SID>getNumber', [2])
    let l:obj['ㅈ'] = function('<SID>getNumber', [3])
    let l:obj['ㅊ'] = function('<SID>getNumber', [4])
    let l:obj['ㅋ'] = function('<SID>getNumber', [3])
    let l:obj['ㅌ'] = function('<SID>getNumber', [4])
    let l:obj['ㅍ'] = function('<SID>getNumber', [4])
    let l:obj['ㄲ'] = function('<SID>getNumber', [4])
    let l:obj['ㄳ'] = function('<SID>getNumber', [4])
    let l:obj['ㄵ'] = function('<SID>getNumber', [5])
    let l:obj['ㄶ'] = function('<SID>getNumber', [5])
    let l:obj['ㄺ'] = function('<SID>getNumber', [7])
    let l:obj['ㄻ'] = function('<SID>getNumber', [9])
    let l:obj['ㄼ'] = function('<SID>getNumber', [9])
    let l:obj['ㄽ'] = function('<SID>getNumber', [7])
    let l:obj['ㄾ'] = function('<SID>getNumber', [9])
    let l:obj['ㄿ'] = function('<SID>getNumber', [9])
    let l:obj['ㅀ'] = function('<SID>getNumber', [8])
    let l:obj['ㅄ'] = function('<SID>getNumber', [6])
    let l:obj['ㅆ'] = function('<SID>getNumber', [4])

    let l:obj['ㅇ'] = function('<SID>getUserInputNumber')
    let l:obj['ㅎ'] = function('<SID>getUserInputChar')
    return l:obj
endfunction

function! s:getNumber(num, memory)
    return a:num
endfunction

function! s:getUserInputNumber(memory)
    let l:args = a:memory.args
    if l:args.size() > 0
        return str2nr(l:args.pop())
    endif
    return str2nr(input('input one Integer : '))
endfunction

function! s:getUserInputChar(memory)
    let l:args = a:memory.args
    if l:args.size() > 0
        return char2nr(l:args.pop())
    endif
    let l:str = input('input one char : ')
    if strchars(l:str) < 1
        return 0
    endif
    return char2nr(strcharpart(l:str, 0, 1))
endfunction

