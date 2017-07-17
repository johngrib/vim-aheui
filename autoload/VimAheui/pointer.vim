scriptencoding utf-8

let s:pointer = {}

function! VimAheui#pointer#new()

    if ! empty(s:pointer)
        return s:reset()
    endif

    let s:pointer = {'x':0, 'y':0}
    let s:pointer.direction = {'x':0, 'y':0}
    let s:pointer.old = s:pointer
    let s:pointer.move = function('<SID>move')
    let s:pointer.step = function('<SID>step')

    let s:pointer['ㅏ'] = function('<SID>right', [1])   " 12623 (min)
    let s:pointer['ㅑ'] = function('<SID>right', [2])   " 12625
    let s:pointer['ㅓ'] = function('<SID>right', [-1])  " 12627
    let s:pointer['ㅕ'] = function('<SID>right', [-2])  " 12629

    let s:pointer['ㅗ'] = function('<SID>down', [-1])   " 12631
    let s:pointer['ㅛ'] = function('<SID>down', [-2])   " 12635
    let s:pointer['ㅜ'] = function('<SID>down', [1])    " 12636
    let s:pointer['ㅠ'] = function('<SID>down', [2])    " 12640

    let s:pointer['ㅡ'] = function('<SID>horizon')      " 12641
    let s:pointer['ㅣ'] = function('<SID>vertical')     " 12643 (max)
    let s:pointer['ㅢ'] = function('<SID>reflect')      " 12642

    let s:pointer['ㅐ'] = function('<SID>move')         " 12624
    let s:pointer['ㅒ'] = function('<SID>move')         " 12626
    let s:pointer['ㅔ'] = function('<SID>move')         " 12628
    let s:pointer['ㅖ'] = function('<SID>move')         " 12630
    let s:pointer['ㅘ'] = function('<SID>move')         " 12632
    let s:pointer['ㅙ'] = function('<SID>move')         " 12633
    let s:pointer['ㅚ'] = function('<SID>move')         " 12634
    let s:pointer['ㅝ'] = function('<SID>move')         " 12637
    let s:pointer['ㅞ'] = function('<SID>move')         " 12638
    let s:pointer['ㅟ'] = function('<SID>move')         " 12639

    return s:pointer
endfunction

function! s:step(cmd) dict
    let l:jung = a:cmd[1]
    if s:validJung(l:jung)
        call self[l:jung]()
    endif
    return self
endfunction

function! s:validJung(char)
    let l:nr = char2nr(a:char)
    return (12623 <= l:nr) && (l:nr <= 12643)
endfunction

function! s:right(m) dict
    let self.direction.x = a:m
    let self.direction.y = 0
    call self.move()
endfunction

function! s:down(m) dict
    let self.direction.x = 0
    let self.direction.y = a:m
    call self.move()
endfunction

function! s:horizon() dict
    if self.y == self.old.y
        call self.go()
    else
        call self.moveBack()
        call self.reverseX()
    endif
endfunction

function! s:vertical() dict
    if self.x == self.old.x
        call self.go()
    else
        call self.moveBack()
        call self.reverseY()
    endif
endfunction

function! s:reflect() dict
    call self.moveBack()
    call self.reverseX()
    call self.reverseY()
endfunction

function! s:reverseX() dict
    let self.direction.x *= -1
endfunction

function! s:reverseY() dict
    let self.direction.y *= -1
endfunction

function! s:reset()
    let s:pointer.x = 0
    let s:pointer.y = 0
    let s:pointer.old = {'x':0, 'y':0}
    let s:pointer.direction = {'x':0, 'y':0}
    return s:pointer
endfunction

function! s:move() dict
    let self.old = {'x':(self.x), 'y':(self.y)}
    let self.x += self.direction.x
    let self.y += self.direction.y
endfunction

function! s:moveBack() dict
    let l:temp = {'x':(self.x), 'y':(self.y)}
    let self.x = self.old.x
    let self.y = self.old.y
    let self.old = l:temp
endfunction

