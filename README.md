# vim-chroot-build
Build in chroots from vim.

## Requirements
schroot (https://linux.die.net/man/1/schroot)

## Installation
Install using Vundle by adding this to your .vimrc:

`Plugin 'sashang/vim-chroot-build'`

or source it:

`:source vim-chroot-build.vim`

## Features and Usage
By default this uses schroot to execute commands within the chroot.

- Vim's working directory should be the one with `configure.ac` present or a subdir.
- The variable `g:vcb_chroot_name` is the name of the chroot. schroot -l will list the chroots on
  your system. Set it to one of these names. For example `let g:vcb_chroot_name=sles12`.
- The variable `g:vcb_user` is the user name used to login to the chroot. For example, `let
  g:vcb_user=joe`

Once those variables are set you can run the following functions to perform common operations in the
chrooted build environment. For the examples below assume that the following configuration is true:

`let g:vcb_chroot_name=sles12`

`let g:vcb_user=joe`

- `call VCBConfigure()`. This will execute ../configure in the path `/home/joe/my-secret-project/build-sles12`

- `call VCBMake()`. This will run make in the path `/home/joe/my-secret-project/build-sles12`

- `call VCBAutoreconf()`. This will run autoreconf inside the chroot. 

