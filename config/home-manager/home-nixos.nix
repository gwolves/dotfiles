{ config, pkgs, ... }:

let
  pkgs-unstable = import <nixpkgs-unstable> {};
in
{
  # configs
  nixpkgs.config.allowUnfree = true;
  xdg.configHome = "/home/gwolves/.config";

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "gwolves";
  home.homeDirectory = "/home/gwolves";

  # Packages
  home.packages = [
    pkgs.nix 

    # shell
    pkgs.tmux
    pkgs.alacritty
    (pkgs.uutils-coreutils.override { prefix = ""; })
    pkgs.less
    pkgs.ripgrep
    pkgs.fd
    pkgs.bat
    pkgs.tldr
    pkgs.lazygit
    pkgs-unstable.eza
    pkgs.libsForQt5.yakuake
    pkgs.guake
    pkgs.jq
    pkgs.yq

    # docker / k8s
    pkgs.kubectl
    pkgs.kubectx
    pkgs.docker-client
    pkgs.docker-compose
    pkgs.colima
    pkgs.stern
    pkgs.k9s
    pkgs.podman-compose

    # dev
    pkgs.poetry
    pkgs.rustup
    pkgs.go
    pkgs.python311
    pkgs.nodejs_20
    pkgs.redis
    pkgs.awscli2
    pkgs.lua-language-server

    # Build
    pkgs.gnumake
    pkgs.gcc
    pkgs.dconf

    # tools
    pkgs.vlc
    pkgs.cloudflare-warp
    pkgs.slack
    pkgs.teleport

    # for fun
    pkgs.citra-nightly
    pkgs.toipe
    pkgs.latte-dock
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Claud Junhyeok Choi";
    userEmail = "gwolves@gwolv.es";
  };

  programs.fish = {
    enable = true;
    shellAbbrs = {
      k = "kubectl";
      h = "home-manager";
      d = "darwin-rebuild";
      np = "nix profile";
      t = "tmux";
      tf = "terraform";
      rgc = "rg -C10 -n";
    };
    shellAliases = {
      rm = "rm -i";
      vi = "nvim";
      vim = "nvim";
      ls = "eza --git --icons";
      vc = "nvim ~/.config/nvim";
      grep = "rg";
    };
    interactiveShellInit = ''
      setxkbmap us-colemak-dh-matrix

      set -g -x XDG_CONFIG_HOME "$HOME/.config"
      set -g -x AWS_PAGER ""
      set -g -x VISUAL $EDITOR

      fish_add_path $HOME/Workspace/gwolv.es/k9s/execs
      fish_add_path $HOME/.cargo/bin
      fish_add_path -m $HOME/.nix-profile/bin

      # use bat as manpager  
      set -g -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
    '';

    functions = {
      toggle_alacritty_opacity = ''
        if test -z $ALACRITTY_OPACITY
          set -g ALACRITTY_OPACITY (yq '.window.opacity' $XDG_CONFIG_HOME/alacritty/alacritty.yml)
        end

        if test $ALACRITTY_OPACITY -eq "1.0"
          alacritty msg config window.opacity=0.8
          set -g ALACRITTY_OPACITY "0.8"
        else
          alacritty msg config window.opacity=1.0
          set -g ALACRITTY_OPACITY "1.0"
        end
      '';

    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;
    withPython3 = false;
    withRuby = false;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.firefox = {
    enable = true;
  };
}

