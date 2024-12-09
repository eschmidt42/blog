{ lib, pkgs, ... }:
{
  targets.genericLinux.enable = true;
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
  home = {
    packages = with pkgs; [
      # terminal
      btop
      git
      (lib.hiPrio vim) # https://haseebmajid.dev/posts/2023-10-02-til-how-to-fix-package-binary-collisions-on-nix/
      starship
      fzf
      zoxide
      eza

      # development
      cargo
      rustc
      rustfmt
      direnv
      
      # zsh oh-my-zsh 

      # fonts
      (pkgs.nerdfonts.override {
        fonts = [ "0xProto" ]; # https://www.nerdfonts.com/font-downloads
      })

      # gui apps
      obsidian # unfree app, require allowUnfree below
      vscode
      podman 
      keepassxc
      veracrypt
      syncthing
      signal-desktop 

      ## libreoffice
      libreoffice-qt
      hunspell
      hunspellDicts.en_US
      hunspellDicts.de_DE
    ];
  
    username = "eric";
    homeDirectory = "/Users/eric";
    shellAliases = {
      gs = "git status";
      gc = "git commit";
      ga = "git add";
      gps = "git push";
      gpl = "git pull";
      gco = "git checkout";
      ls = "eza --icons=auto";
      btop2 = "btop -p 2";
    };
    stateVersion = "24.05";
    sessionVariables= {
      EDITOR = "vim";
      VISUAL = "vim";
    };


  };
  imports = [ # includes uv (needs compilation)
    ./uv.nix
  ];
  
  fonts = {
    fontconfig.enable = true;
  };
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # jupyter
      ms-toolsai.jupyter
      ms-toolsai.vscode-jupyter-slideshow
      ms-toolsai.vscode-jupyter-cell-tags
      ms-toolsai.jupyter-renderers
      ms-toolsai.jupyter-keymap
      # python
      ms-python.python
      ms-python.debugpy
      ms-python.vscode-pylance
      # rust
      rust-lang.rust-analyzer
      # other
      ms-vscode.makefile-tools
      yzhang.markdown-all-in-one
      timonwong.shellcheck
      mhutchie.git-graph
      continue.continue
      jnoortheen.nix-ide
      tamasfe.even-better-toml
      ms-azuretools.vscode-docker
    ];
  };
  programs.direnv = {
    enable = true;
  };
  programs.eza = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.bash = {
    enable = true;
  };
  programs.git = {
   enable = true;
   userName = "YOUR-USER-NAME";
   userEmail = "YOUR-EMAIL@users.noreply.github.com";
   extraConfig.pull.rebase = true;
  };
  programs.vim.enable = true;
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true; # required for obsidian
}
