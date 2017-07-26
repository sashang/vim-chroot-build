# vim-chroot-build
Build in chroots from vim.

## Requirements
- schroot (https://linux.die.net/man/1/schroot)
- autotools

## What on earth is this schroot/chroot thing
Basically if you want to build for a distribution that is different from the one you use, what you
can do is make a of the filesystem image of the target distribution, install the build tools you
need on this filesystem and then run it in a chroot. So for example if I'm using Arch as my desktop
environment but I want to compile my programs for SLES11 or Ubuntu12 or Centos5 I can make
filesystem images for those distributions and use schroot to manage them, while preserving my home
directory. You can think of it as virtualizing the filesystem. This plugin just runs the build steps
in the chrooted environment so you don't have to manually do it.

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
- The variable `g:vcb_configure_args` contains arguments to pass to configure.

Once those variables are set you can run the following functions to perform common operations in the
chrooted build environment. For the examples below assume that the following configuration is true:

`let g:vcb_chroot_name=sles12`

`let g:vcb_user=joe`

`let g:vcb_configure_args=--enable-this --disable-that`

- `call VCBConfigure()`. This will execute ../configure in the path `/home/joe/my-secret-project/build-sles12`

- `call VCBMake()`. This will run make in the path `/home/joe/my-secret-project/build-sles12`

- `call VCBAutoreconf()`. This will run autoreconf inside the chroot. 

