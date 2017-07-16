scriptencoding utf-8

let s:rawCode = ''
let s:codeList = []
let s:code = []

function! VimAheui#debugger#run()

    let s:rawCode = s:getCodeOnCursor()
    let s:codeList = s:getCodeList(s:rawCode)
    let s:code = s:getDividedCode(s:codeList)

endfunction

function! s:getCodeList(rawCode)
    let l:codeList = split(a:rawCode, '\n')
    call map(l:codeList, {ind, val -> split(val, '.\zs')})
    return l:codeList
endfunction

function! s:getDividedCode(codeList)
    let l:code = deepcopy(a:codeList)
    for line in l:code
        call map(line, {ind, val -> VimAheui#hangul#divide(val)})
    endfor
    return l:code
endfunction

function! s:getCursorChar()
    return matchstr(getline('.'), '\%' . col('.') . 'c.')
endfunction

function! s:getCodeOnCursor()
    let l:temp = @z
    execute 'normal! "zyip'
    let l:code = @z
    let @z = l:temp
    return l:code
endfunction

