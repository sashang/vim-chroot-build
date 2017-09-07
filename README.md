# vim-chroot-build
Build in chroots from vim.

## Requirements
- schroot (https://linux.die.net/man/1/schroot)
- autotools
- AsyncRun (https://github.com/skywind3000/asyncrun.vim)

## What on earth is this schroot/chroot thing
Basically if you want to build for a distribution that is different from the one you use, what you
can do is make a filesystem image of the target distribution, install the build tools you need on
this filesystem and then run it in a chroot. So for example if I'm using Arch as my desktop
environment but I want to compile my programs for SLES11 or Ubuntu12 or Centos5 I can make
filesystem images for those distributions and use schroot to manage them. schroot will automount my
home directory inside the chroot. This is very useful. Using a container you will have to configure
this yourself. You can think of a chroot as something that virtualizes the filesystem only, as
opposed to a container which virtualizes everything above the kernel (filesystem, network resources,
processes etc...). This plugin just runs the build steps in the chrooted environment so you don't
have to manually do it.

## Installation
Install using Vundle by adding this to your .vimrc in your Vundle section:

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

- `:SConfigure`. This will execute ../configure in the path `/home/joe/my-secret-project/build-sles12`

- `:SMake`. This will run make in the path `/home/joe/my-secret-project/build-sles12`

- `:SAutoreconf`. This will run autoreconf inside the chroot. 

- `:SStop`. Stop any command currently executing.

You can change the compiler by setting the following global variables:

`let g:vcb_cc='ccache\ gcc'`
`let g:vcb_cxx='ccache\ g++'`

