" Name:          vim-chroot-build (global plugin)
" Version:       1.0
" Author:        Sashan Govender <sashang@gmail.com>
" Updates:       http://github.com/sashang/vim-chroot-build
" Purpose:       Build source code within a chroot using schroot.
"
" License:       You may redistribute this plugin under the same terms as Vim
"                itself.
"

let s:vcb_src_path = ""

" search up parent until $HOME for configure.ac
function! VCBFindConfigureac()
    let l:path = getcwd()
    while (1)
        " ==# is the case sensitive match, == depends on what the ignorecase is set to.
        if (l:path ==# $HOME)
            echoe "Could not find configure.ac"
            return 0
        else
            let l:find = l:path."/configure.ac"
            if filereadable(l:find)
                echom "Found configure.ac: ".l:find
                let s:vcb_src_path = l:path
                return 1
            else
                let l:path = fnamemodify(l:path, ":h")
            endif
        endif
    endwhile
endfunction

" ensure global settings are nor empty
function! VCBEnsureGlobals()
    if empty(g:vcb_chroot_name)
        echoe 'Please set vcb_chroot_name'
        return 0
    endif
    if empty(g:vcb_user)
        echoe 'Please set vcb_user'
        return 0
    endif
    return 1
endfunction

function! VCBMkBuildDir()
    if !VCBFindConfigureac() || !VCBEnsureGlobals()
        echoe 'Failed to make build dir'
        return 0
    endif
    execute '!mkdir '.s:vcb_src_path.'/build-'.g:vcb_chroot_name
    return 1
endfunction

function! VCBAutoreconf()
    if !VCBFindConfigureac() || !VCBEnsureGlobals()
        echoe 'Failed to run autoreconf'
        return 0
    endif
    execute '!env -i SHELL=/bin/bash TERM=xterm CC="ccache gcc" CXX="ccache g++"
        \ schroot -p -u'.g:vcb_user.' -c'.g:vcb_chroot_name.' -d'.s:vcb_src_path.' -- autoreconf -vfi'
    return 1
endfunction

function! VCBConfigure()
    if !VCBFindConfigureac() || !VCBEnsureGlobals()
        return 0
    endif
    VCBMkBuildDir()
    execute '!env -i SHELL=/bin/bash TERM=xterm CC="ccache gcc" CXX="ccache g++"
        \ schroot -p -u'.g:vcb_user.' -c'.g:vcb_chroot_name.' -d'.s:vcb_src_path.'/build-'.g:vcb_chroot_name.' -- ../configure'
    return 1
endfunction

function! VCBMake(...)
    if !VCBFindConfigureac() || !VCBEnsureGlobals()
        return 0
    endif
    VCBMkBuildDir()
    let l:temp = &makeprg
    if a:0 == 1
        let &makeprg = 'env -i SHELL=/bin/bash TERM=xterm CC="ccache gcc" CXX="ccache g++"
            \ schroot -p -u'.g:vcb_user.' -c'.g:vcb_chroot_name.' -d'.s:vcb_src_path.'/build-'.g:vcb_chroot_name.' -s /bin/bash -- make '.a:1
    else
        let &makeprg = 'env -i SHELL=/bin/bash TERM=xterm CC="ccache gcc" CXX="ccache g++"
            \ schroot -p -u'.g:vcb_user.' -c'.g:vcb_chroot_name.' -d'.s:vcb_src_path.'/build-'.g:vcb_chroot_name.' -s /bin/bash -- make'
    endif
    execute 'make'
    let &makeprg = l:temp
    return 1
endfunction

