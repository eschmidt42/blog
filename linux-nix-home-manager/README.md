# Arch & nix home-manager setup

> Making uv, vscode, signal and other goodies available via nix home-manager for a single user. 

## Before you start

It is recommended to try any nix home-manager setup in a VM first. You may otherwise accidentally break your current setup. For steps on how to set up arch on ubuntu check out these two guides: [arch vm on ubuntu](https://ericschmidt.xyz/2024/11/03/setting-up-a-basic-arch-linux-vm-on-ubuntu-24-04/) and [stapling a gui onto arch](https://ericschmidt.xyz/2024/11/04/stapling-a-gui-on-an-arch-vm/).

Also, the following steps will assume you are on a system that has `make` to process the "Makefile" file. But that's only for convenience. If you do not have `make`, just open "Makefile" whenever a command below uses `make` and copy the lines from the "Makefile" into your terminal.

## Single user install of `nix`

Let's go

    su - root
    mkdir -m 0755 /nix && chown eric /nix
    exit

Install single user nix

    sh <(curl -L https://nixos.org/nix/install) --no-daemon

see the [docs](https://nixos.org/download/#nix-install-linux) for more info. 

Let's add two [`nix-channel`](https://nixos.wiki/wiki/Nix_channels)s we will need, first the nixos channel 

    nix-channel --add https://nixos.org/channels/nixos-24.05 nixpkgs
    nix-channel --update nixpkgs

and then the home manager channel

    nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
    nix-channel --update home-manager

Then install install `home-manager`

    nix-shell '<home-manager>' -A install

## Building the config

Clone this repo

    git clone https://github.com/eschmidt42/blog.git
    
and then 

    cd blog/linux-nix-home-manager 

There we have 

* [flake.nix](flake.nix): flake to define our setup, calls [home.nix](home.nix) from [this line](flake.nix#25), requires experimental feature *flakes*
* [home.nix](home.nix): config that specifies our cli setup and apps to call from the cli, e.g. `uv` by calling [uv.nix](uv.nix) from [this line](home.nix#69)
* [uv.nix](uv.nix): setup to compile `uv` 0.5.7 from github

Before continuing you may want to comment out [the uv.nix import line in home.nix](home.nix#69) in home.nix, to prevent compilation of `uv`, because it will require 12GB of RAM (if you have less available the build will fail) and also quite some time.

After you may or may not have commented out that line run

    make update

You may immediately get an error saying experimental features are not enabled. To fix this run 

    make conf

and then try 

    make update
    
again. 

If you ever get some weird error log with `make update` and want to know more you can instead run

    make update-trace

If everything went through fine you could try running

    btop2

to have an elegant cli activity monitor or even

    code

to start vscode, with the specified extensions included already.

Enjoy!

## References

* hands-on intro the above is based on: https://github.com/Evertras/simple-homemanager/tree/main
* NixOS & Flakes Book: https://nixos-and-flakes.thiscute.world/
* official manual: https://nix.dev/manual/nix/2.18/language/
* search
  * packages: https://search.nixos.org/packages?channel=24.05&size=50&sort=relevance&type=packages&query=vscode+python
  * options #1: https://search.nixos.org/options?channel=24.05&from=0&size=50&sort=relevance&type=packages&query=unfree
  * options #2: https://mynixos.com/home-manager/options
* fonts
  * https://general-metrics.com/articles/nixos-nerd-fonts/
  * https://nixos.asia/en/tips/hm-fonts
