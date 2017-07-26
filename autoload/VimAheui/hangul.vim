scriptencoding utf-8

let s:cho = ['ㄱ','ㄲ','ㄴ','ㄷ','ㄸ','ㄹ','ㅁ','ㅂ','ㅃ','ㅅ','ㅆ','ㅇ','ㅈ','ㅉ','ㅊ','ㅋ','ㅌ','ㅍ','ㅎ']
let s:jung = ['ㅏ','ㅐ','ㅑ','ㅒ','ㅓ','ㅔ','ㅕ','ㅖ','ㅗ','ㅘ','ㅙ','ㅚ','ㅛ','ㅜ','ㅝ','ㅞ','ㅟ','ㅠ','ㅡ','ㅢ','ㅣ']
let s:jong = ['','ㄱ','ㄲ','ㄳ','ㄴ','ㄵ','ㄶ','ㄷ','ㄹ','ㄺ','ㄻ','ㄼ','ㄽ','ㄾ','ㄿ','ㅀ','ㅁ','ㅂ','ㅄ','ㅅ','ㅆ','ㅇ','ㅈ','ㅊ','ㅋ','ㅌ','ㅍ','ㅎ']

" char2nr('가') => 44032
" char2nr('힣') => 55203

" nr2char(44032) => '가'
" nr2char(55203) => '힣'

function! VimAheui#hangul#divide(char)

    let l:num = char2nr(a:char)

    if l:num < 44032 || l:num > 55203
        return s:getNone(a:char)
    endif

    let l:num = char2nr(a:char) - 44032

    let l:cho = l:num / 588
    let l:jung = (l:num % 588) / 28
    let l:jong = l:num % 28

    return {'cho': get(s:cho, l:cho, ''), 'jung': get(s:jung, l:jung, ''), 'jong': get(s:jong, l:jong, ''), 'char': a:char, 'reverse': 0, 'break': 0, 'stepPass': 0}

endfunction

function! s:getNone(char)
    return {'cho': '', 'jung': '', 'jong': '', 'char': a:char, 'reverse': 0, 'break': 0, 'stepPass': 1}
endfunction

