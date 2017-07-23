scriptencoding utf-8

function! s:isValidVersion(version)
    return a:version >= 800
endfunction

if ! s:isValidVersion(v:version)
    echomsg 'vim-aheui: requires at least Vim 8.0'
    finish
endif

command! -nargs=0 AheuiStep call VimAheui#debugger#step()
command! -nargs=0 AheuiRun call VimAheui#debugger#run(0, 0)
command! -nargs=0 AheuiRunIgnoreBreak call VimAheui#debugger#run(1, 0)

nmap <F2> :AheuiStep<CR>

command! -nargs=0 AheuiConsoleOpen call VimAheui#console#open()
command! -nargs=0 AheuiConsoleClose call VimAheui#console#close()
command! -nargs=0 AheuiInspectorOpen call VimAheui#inspector#open()
command! -nargs=0 AheuiInspectorClose call VimAheui#inspector#close()
