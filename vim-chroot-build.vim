
function! VCBCheckConfigure()
    if empty(g:vcb_src_path)
        let s:path=getcwd()
        echo s:path
    else
        let s:path=g:vcb_src_path()
    endif
    if filereadable(s:path."/configure.ac")
        return 1
    else
        echo "Could not find configure.ac in '".g:vcb_src_path."' Is g:vcb_src_path set correctly?"
        return 0
    endif
endfunction

function! VCBAutoreconf()
    if VCBCheckConfigure()
        cd g:vcb_src_path
        execute '!autoreconf -fvi'
        return 1
    endif
    return 0
endfunction

function! VCBConfigure()
    if empty(g:vcb_src_path)
        let s:path=getcwd()
        echo s:path
    else
        let s:path=g:vcb_src_path()
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
        echo s:path
    else
        let s:path=g:vcb_src_path()
    endif
    let l:temp = &makeprg
    if a:0 == 1
        let &makeprg = 'schroot -p -u'.g:vcb_user.' -c'.g:vcb_chroot_name.' -d'.s:path.'/build-'.g:vcb_chroot_name.' -- make '.a:1
    else
        let &makeprg = 'schroot -p -u'.g:vcb_user.' -c'.g:vcb_chroot_name.' -d'.s:path.'/build-'.g:vcb_chroot_name.' -- make'
    endif
    execute 'make'
    let &makeprg = l:temp
endfunction

