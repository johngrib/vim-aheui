function! VimAheui#util#new()
    let l:obj = {}
    let l:obj.getCursorChar = function('<SID>getCursorChar')
    let l:obj.getCodeList = function('<SID>getCodeList')
    let l:obj.getDividedCode = function('<SID>getDividedCode')
    return l:obj
endfunction

function! VimAheui#util#getCodeOnEditor()
    let l:temp = @z
    execute 'silent! normal! gg"zyG'
    let l:code = @z
    let @z = l:temp
    return l:code
endfunction

function! s:getCursorChar()
    return matchstr(getline('.'), '\%' . col('.') . 'c.')
endfunction

function! s:getCodeList(rawCode)
    let l:codeList = split(a:rawCode, '\n', 1)

    let l:length = copy(l:codeList)
    call map(l:length, {key, val -> strchars(val)})

    let l:max_length = max(l:length)

    let l:index = 0
    for line in l:codeList
        let l:size = strchars(line)
        if l:size < l:max_length
            let line .= repeat(' ', l:max_length - l:size)
            let l:codeList[l:index] = line
        endif
        let l:index += 1
    endfor

    call map(l:codeList, {ind, val -> split(val, '.\zs')})
    call map(l:codeList, {ind, val -> len(val) < 1 ? [''] : val})
    return l:codeList
endfunction

function! s:getDividedCode(codeList)
    let l:code = deepcopy(a:codeList)
    for line in l:code
        call map(line, {ind, val -> VimAheui#hangul#divide(val)})
    endfor
    return l:code
endfunction

