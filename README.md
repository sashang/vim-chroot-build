# vim-chroot-build
Build in chroots from vim.

## Installation
`:source ~/vim-chroot-build`

## Features and Usage
By default this uses schroot to execute commands within the chroot.

- The variable `g:vcb_chroot_name` is the name of the chroot. schroot -l will list the chroots on
  your system. Set it to one of these names. For example `let g:vcb_chroot_name=sles12`. 
- The variable `g:vcb_user` is the user name used to login to the chroot. For example, `let
  g:vcb_user=joe`
- The variable `g:vcb_src_path` is the path to the source code.

Once those variables are set you can run the following functions to perform common operations in the
chrooted build environment. For the examples below assume that the following configuration is true:

`let g:vcb_chroot_name=sles12`

`let g:vcb_user=joe`

`let g:vcb_src_path=/home/joe/my-secret-project`

- `call VCBConfigure()`. This will execute ../configure in the path `/home/joe/my-secret-project/build-sles12`

- `call VCBMake()`. This will run make in the path `/home/joe/my-secret-project/build-sles12`

- `call VCBAutoreconf()`. This will run autoreconf *outside* the chroot since the output from
  autoreconf is generates files so that configure can run on any host. There wouldn't be any harm in
  running it inside the chroot, but if you have multiple chroots then running autoreconf from inside
  them will create different INSTALL, ltmain.sh, aclocal.m4 files etc... per chroot.

