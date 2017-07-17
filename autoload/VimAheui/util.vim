function! VimAheui#util#new()
    let l:obj = {}
    let l:obj.getCodeOnCursor = function('<SID>getCodeOnCursor')
    let l:obj.getCursorChar = function('<SID>getCursorChar')
    let l:obj.getCodeList = function('<SID>getCodeList')
    let l:obj.getDividedCode = function('<SID>getDividedCode')
    return l:obj
endfunction

function! s:getCodeOnCursor()
    let l:temp = @z
    execute 'silent! normal! "zyip'
    let l:code = @z
    let @z = l:temp
    return l:code
endfunction

function! s:getCursorChar()
    return matchstr(getline('.'), '\%' . col('.') . 'c.')
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

