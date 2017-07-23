scriptencoding utf-8

let s:stackNames = []
call add(s:stackNames, '')      " 0
call add(s:stackNames, 'ㄱ')    " 12593
call add(s:stackNames, 'ㄴ')    " 12596
call add(s:stackNames, 'ㄷ')    " 12599
call add(s:stackNames, 'ㄹ')    " 12601
call add(s:stackNames, 'ㅁ')    " 12609
call add(s:stackNames, 'ㅂ')    " 12610
call add(s:stackNames, 'ㅅ')    " 12613
call add(s:stackNames, 'ㅈ')    " 12616
call add(s:stackNames, 'ㅊ')    " 12618
call add(s:stackNames, 'ㅋ')    " 12619
call add(s:stackNames, 'ㅌ')    " 12620
call add(s:stackNames, 'ㅍ')    " 12621
call add(s:stackNames, 'ㄲ')    " 12594
call add(s:stackNames, 'ㄳ')    " 12595
call add(s:stackNames, 'ㄵ')    " 12597
call add(s:stackNames, 'ㄶ')    " 12598
call add(s:stackNames, 'ㄺ')    " 12602
call add(s:stackNames, 'ㄻ')    " 12603
call add(s:stackNames, 'ㄼ')    " 12604
call add(s:stackNames, 'ㄽ')    " 12605
call add(s:stackNames, 'ㄾ')    " 12606
call add(s:stackNames, 'ㄿ')    " 12607
call add(s:stackNames, 'ㅀ')    " 12608
call add(s:stackNames, 'ㅄ')    " 12612
call add(s:stackNames, 'ㅆ')    " 12614

let s:queueNames = ['ㅇ']
let s:pipeNames = ['ㅎ']
let s:default = ''

function! VimAheui#memory#new()

    let l:collection = {}
    call extend(l:collection, s:initStack())
    call extend(l:collection, s:initQueue())
    call extend(l:collection, s:initPipe())

    let l:collection.toStringList = function('<SID>toStringList')
    let l:collection.get = function('<SID>get')
    let l:collection.select = function('<SID>select')
    let l:collection.getSelected = function('<SID>getSelected')
    call l:collection.select(s:default)

    return l:collection
endfunction

function! s:initStack()
    let l:stack = {}
    for name in s:stackNames
        let l:stack[name] = VimAheui#stack#new(name)
    endfor
    return l:stack
endfunction

function! s:initQueue()
    let l:queue = {}
    for name in s:queueNames
        let l:queue[name] = VimAheui#queue#new(name)
    endfor
    return l:queue
endfunction

function! s:initPipe()
    let l:pipe = {}
    for name in s:pipeNames
        let l:pipe[name] = VimAheui#pipe#new(name)
    endfor
    return l:pipe
endfunction

function! s:get(name) dict
    if ! has_key(self, a:name)
        throw a:name . ' is not exist'
    endif
    return self[(a:name)]
endfunction

function! s:select(name) dict
    let self.selected = self.get(a:name)
endfunction

function! s:getSelected() dict
    return self.selected
endfunction

function! s:toStringList() dict
    let l:list = []
    for stack_name in s:stackNames
        call add(l:list, self[stack_name].toString())
    endfor
    for queue_name in s:queueNames
        call add(l:list, self[queue_name].toString())
    endfor
    for pipe_name in s:pipeNames
        call add(l:list, self[pipe_name].toString())
    endfor
    return l:list
endfunction
