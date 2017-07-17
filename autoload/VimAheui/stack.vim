scriptencoding utf-8

function! VimAheui#stack#new()

    let l:obj = {}
    let l:obj.list = []
    let l:obj.push = function('<SID>push')
    let l:obj.pop = function('<SID>pop')
    let l:obj.dup = function('<SID>dup')
    let l:obj.size = function('<SID>size')
    let l:obj.toString = function('<SID>toString')

    return l:obj
endfunction

function! s:push(item) dict
    let self.list += [a:item]
endfunction

function! s:pop() dict
    if len(self.list) < 1
        throw 'pop error : Stack is empty'
    endif
    let l:item = self.list[-1]
    let self.list = self.list[:-2]
    return l:item
endfunction

function! s:dup() dict
    if len(self.list) < 1
        throw 'dup error : Stack is empty'
    endif
    let self.list += [(self.list[-1])]
endfunction

function! s:size() dict
    return len(self.list)
endfunction

function! s:toString() dict
    return string(self.list)
endfunction
