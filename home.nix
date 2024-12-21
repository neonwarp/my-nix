{ config, pkgs, ... }:

{
  home = rec {
    username = "user";
    homeDirectory = "/home/${username}";

    stateVersion = "24.11";

    packages = [
      pkgs.volta
      pkgs.go
      pkgs.deno
      pkgs.zoxide
      pkgs.fzf
      pkgs.ripgrep
      pkgs.starship
      pkgs.rustup
      pkgs.gcc
      pkgs.pkg-config
      pkgs.openssl
    ];

    sessionVariables = {
      RUST_BACKTRACE = "full";
      PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig";
    };
  };

  programs = {
    home-manager.enable = true;

    bash = {
      enable = true;
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };

    starship = {
      enable = true;
      settings = {
        add_newline = true;
      };
    };

    git = {
      enable = true;
      userName = "";
      userEmail = "";
      extraConfig = {
        push = { autoSetupRemote = true; };
        fetch = { rebase = true; };
      };
      aliases = {
        a = "add --all";
        b = "branch";
        ls = "branch -a";
        c = "commit -am";
        ca = "!git add -A && git commit -am";
        co = "checkout";
        d = "diff --color --color-words --abbrev";
        dt = "difftool";
        p = "push";
        r = "rebase";
        s = "status -sb";
        l = "log --decorate --all --graph";
        h = "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short";
      };
    };
  };
}
