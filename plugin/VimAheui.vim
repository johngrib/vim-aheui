scriptencoding utf-8

function! s:isValidVersion(version)
    return a:version >= 800
endfunction

if ! s:isValidVersion(v:version)
    echomsg 'vim-aheui: requires at least Vim 8.0'
    finish
endif

command! -nargs=0 AheuiRun call VimAheui#debugger#run()

command! -nargs=0 AheuiConsoleOpen call VimAheui#console#open()
