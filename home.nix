{ config, pkgs, ... }:

{
  home = rec {
    username = "user";
    homeDirectory = "/home/${username}";

    stateVersion = "24.11";

    packages = with pkgs; [
      volta
      go
      deno
      zoxide
      fzf
      ripgrep
      ast-grep
      starship
      rustup
      gcc
      pkg-config
      openssl
      dotnet-sdk
    ];

    sessionVariables = {
      RUST_BACKTRACE = "full";
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
      DOTNET_CLI_TELEMETRY_OPTOUT = 1;
    };
  };

  programs = {
    home-manager.enable = true;

    bash = {
      enable = true;
      initExtra = ''
        export VOLTA_HOME="$HOME/.volta"
        export PATH="$VOLTA_HOME/bin:$PATH"
      '';
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
        init = { defaultBranch = "main"; };
        color = { ui = "always"; };
        help = { autoCorrect = true; };
        push = {
          followTags = true;
          autoSetupRemote = true;
        };
        pull = { rebase = true; };
        fetch = { prune = true; };
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
