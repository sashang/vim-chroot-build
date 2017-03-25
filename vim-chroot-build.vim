
function! VCBCheckConfigure()
    if empty(g:vcb_src_path)
        let s:path=getcwd()
        echo s:path
    else
        let s:path=g:vcb_src_path
    endif
    if filereadable(s:path."/configure.ac")
        return 1
    else
        echo "Could not find configure.ac in '".g:vcb_src_path."' Is g:vcb_src_path set correctly?"
        return 0
    endif
endfunction

" search up parent until $HOME for configure.ac
function! VCBFindConfigureac()
    let l:path = getcwd()
    while (1)
        " ==# is the case sensitive match, == depends on what the ignorecase is set to.
        if (l:path ==# $HOME)
            echom "Could not find configure.ac"
            return 0
        else
            let l:find = l:path."/configure.ac"
            echom l:find
            if filereadable(l:find)
                return 1
            else
                let l:path = fnamemodify(l:path, ":h")
            endif
        endif
    endwhile
endfunction

function! VCBAutoreconf()
    if empty(g:vcb_src_path)
        let s:path=getcwd()
        echo s:path
    else
        let s:path=g:vcb_src_path
    endif
    if VCBCheckConfigure()
        let f = system("cd ".g:vcb_src_path."; autoreconf -fvi")
        echo f
        return 1
    endif
    return 0
endfunction

function! VCBConfigure()
    if empty(g:vcb_src_path)
        let s:path=getcwd()
    else
        let s:path=g:vcb_src_path
    endif
    if VCBCheckConfigure()
        execute '!schroot -p -u'.g:vcb_user.' -c'.g:vcb_chroot_name.' -d'.s:path.'/build-'.g:vcb_chroot_name.' -- ../configure'
        return 1
    else
        return 0
    endif
endfunction

function! VCBMake(...)
    if empty(g:vcb_src_path)
        let s:path=getcwd()
    else
        let s:path=g:vcb_src_path
    endif
    echom s:path
    let l:temp = &makeprg
    if a:0 == 1
        let &makeprg = 'schroot -u'.g:vcb_user.' -c'.g:vcb_chroot_name.' -d'.s:path.'/build-'.g:vcb_chroot_name.' -- make '.a:1
    else
        let &makeprg = 'schroot -u'.g:vcb_user.' -c'.g:vcb_chroot_name.' -d'.s:path.'/build-'.g:vcb_chroot_name.' -- make'
    endif
    execute 'make'
    let &makeprg = l:temp
endfunction

