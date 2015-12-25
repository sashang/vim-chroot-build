# vim-chroot-build
Build in chroots from vim.

### Features and Usage
By default this uses schroot to execute commands within the chroot.

- The variable `g:vcb_chroot_name` is the name of the chroot. schroot -l will list the chroots on
  your system. Set it to one of these names. For example `let g:vcb_chroot_name=sles12`. 
- The variable `g:vcb_user` is the user name used to login to the chroot. For example, `let
  g:vcb_user=joe`
- The variable `g:vcb_src_path` is the path to the source code.

Once those variables are set you can run the following functions to perform common operations in the
chrooted build environment.

- `call VCBConfigure()`. This will execute ../configure in the path `g:vcb_src_path`/build-`g:vcb_chroot_name`
- `call VCBMake()`. This will run make in the path `g:vcb_src_path`/build-`g:vcb_chroot_name`

