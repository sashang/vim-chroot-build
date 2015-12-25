let g:vcb_src_path=''
let g:vcb_user=''
let g:vcb_chroot_name=''

function! VCBCheckConfigure()
    if filereadable(g:vcb_src_path."/configure.ac")
        echo "test"
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
    if VCBCheckConfigure()
        execute '!schroot -u'.g:vcb_user.' -c'.g:vcb_chroot_name.' -d'.g:vcb_src_path.'/build-'.g:vcb_chroot_name.' -- ../configure'
        return 1
    else
        return 0
    endif
endfunction

function! VCBMake()
    let l:temp = &makeprg
    let &makeprg = 'schroot -u'.g:vcb_user.' -c'.g:vcb_chroot_name.' -d'.g:vcb_src_path.'/build-'.g:vcb_chroot_name.' -- make'
    execute 'make'
    let &makeprg = l:temp
endfunction

