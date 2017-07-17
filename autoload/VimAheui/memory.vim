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

function! VimAheui#memory#new()
    let l:obj = {}
    let l:obj.stack = s:initStack()
    let l:obj.queue = s:initQueue()
    let l:obj.pipe = s:initPipe()
    let l:obj.getStack = function('<SID>getStack')
    let l:obj.getQueue = function('<SID>getQueue')
    let l:obj.getPipe = function('<SID>getPipe')
    return l:obj
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

function! s:getStack(name) dict
    if ! has_key(self.stack, a:name)
        throw a:name . ' stack is not exist'
    endif
    return self.stack[(a:name)]
endfunction

function! s:getQueue(name) dict
    if ! has_key(self.queue, a:name)
        throw a:name . ' queue is not exist'
    endif
    return self.queue[(a:name)]
endfunction

function! s:getPipe(name) dict
    if ! has_key(self.pipe, a:name)
        throw a:name . ' pipe is not exist'
    endif
    return self.pipe[(a:name)]
endfunction
