{ config, lib, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "martin";
  home.homeDirectory = "/home/martin";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    zsh-powerlevel10k

    _1password-cli
    _1password-gui

    ripgrep # for Telescope live grep

    sesh
    # Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Include and manage local files
  home.file = {
    ".config/zsh/.p10k.zsh".source = ./config/zsh/p10k.zsh; # P10k config

    ".config/1Password/ssh/agent.toml".source =
      ./config/1Password/ssh/agent.toml;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/martin/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  fonts.fontconfig = { enable = true; };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    dotDir = ".config/zsh";
    enable = true;
    enableCompletion = true;
    autocd = true;
    initExtraFirst = ''
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme  
      test -f ~/.config/zsh/.p10k.zsh && source ~/.config/zsh/.p10k.zsh  
    '';
    shellAliases = {
      c = "clear";
      rebuild-home = "home-manager switch --flake ~/.dotfiles/";
      rebuild-config = "sudo nixos-rebuild switch --flake ~/.dotfiles/";

    };
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };
  };

  # Enable google chrome
  programs.google-chrome = { enable = true; };

  programs.ssh = {
    enable = true;
    extraConfig = ''
            Host *
      	IdentityAgent ~/.1password/agent.sock
    '';
  };

  programs.git = {
    enable = true;
    userName = "Martin Skatvedt";
    userEmail = "martin.skatvedt@disruptive-technologies.com";
    extraConfig = {
      gpg = { format = "ssh"; };
      "gpg \"ssh\"" = {
        program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      };
      commit = { gpgsign = true; };

      user = {
        signingKey =
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF7ypPYl6R+y3Q65sCe3XHupmDCZgr/TZ9wKevZfCVuh";
      };

      "url \"git@bitbucket.org:\"" = { insteadof = "https://bitbucket.org/"; };
    };
  };

  home.file.".config/nvim/" = {
    source = ./config/nvim;
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
  };

  # Sesh config files
  home.file.".config/sesh/" = {
    source = ./config/sesh;
    recursive = true;
  };

  # tmux-powerline config files
  home.file.".config/tmux-powerline/" = {
    source = ./config/tmux-powerline;
    recursive = true;
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    clock24 = true;

    plugins = with pkgs.tmuxPlugins;
      [
        #"tmux-plugins/tmux-sensible"
        #"erikw/tmux-powerline"
        tmux-powerline

      ];

    extraConfig = ''
            set-option -g update-environment "PATH"

            bind h select-pane -L
            bind j select-pane -D
            bind k select-pane -U
            bind l select-pane -R

            bind-key x kill-pane # skip "kill-pane 1? (y/n)" prompt
            set -g detach-on-destroy off  # don't exit from tmux when closing a session

            bind-key "T" run-shell "sesh connect \"$(
      	    sesh list | fzf-tmux -p 55%,60% \
      		--no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
      		--header '  ^a all ^t tmux ^g configs ^d tmux kill' \
      		--bind 'tab:down,btab:up' \
      		--bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list)' \
      		--bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t)' \
      		--bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c)' \
      		--bind 'ctrl-d:execute(tmux kill-session -t {})+change-prompt(⚡  )+reload(sesh list)'
          )\""
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

