scriptencoding utf-8

function! VimAheui#queue#new(name)

    let l:obj = {}
    let l:obj.name = a:name
    let l:obj.type = 'Queue'
    let l:obj.list = []
    let l:obj.push = function('<SID>push')
    let l:obj.pop = function('<SID>pop')
    let l:obj.dup = function('<SID>dup')
    let l:obj.swap = function('<SID>swap')
    let l:obj.size = function('<SID>size')
    let l:obj.toString = function('<SID>toString')

    return l:obj
endfunction

function! s:push(item) dict
    let self.list += [a:item]
endfunction

function! s:pop() dict
    if len(self.list) < 1
        throw 'pop : ' . (self.type) . (self.name) . ' is empty'
    endif
    let l:item = self.list[0]
    let self.list = self.list[1:]
    return l:item
endfunction

function! s:dup() dict
    if len(self.list) < 1
        throw 'dup : ' . (self.type) . (self.name) . ' is empty'
    endif
    let self.list = [(self.list[0])] + self.list
endfunction

function! s:swap() dict
    if len(self.list) < 2
        throw 'swap : ' . (self.type) . (self.name) . ' size is ' . len(self.list)
    endif
    let l:head = self.list[0]
    let self.list[0] = self.list[1]
    let self.list[1] = l:head
endfunction

function! s:size() dict
    return len(self.list)
endfunction

function! s:toString() dict
    return (self.type) . (self.name) . string(self.list)
endfunction
