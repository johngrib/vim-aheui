scriptencoding utf-8

let s:pointer = {}

function! VimAheui#pointer#new()

    if ! empty(s:pointer)
        return s:pointer
    endif

    let s:pointer = {'x':0, 'y':0}
    let s:pointer.direction = {'x':0, 'y':0}
    let s:pointer.old = s:pointer
    let s:pointer.move = function('<SID>move')

    return s:pointer

endfunction

function! s:reset()
    let s:pointer.x = 0
    let s:pointer.y = 0
    let s:pointer.old = {'x':0, 'y':0}
    let s:pointer.direction = {'x':0, 'y':0}
endfunction

function! s:move() dict
    let self.old = {'x':(self.x), 'y':(self.y)}
    let self.x += self.direction.x
    let self.y += self.direction.y
endfunction

