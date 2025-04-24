{ pkgs, ... }:

{

  home.packages = with pkgs; [ zsh-powerlevel10k zsh-fzf-tab ];

  home.file.".config/zsh/.p10k.zsh" = { source = ../config/zsh/p10k.zsh; };

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
    initExtra = ''
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
      zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
      zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
      # apply to all command
      zstyle ':fzf-tab:*' popup-min-size 50 8
      # only apply to 'diff'
      zstyle ':fzf-tab:complete:diff:*' popup-min-size 80 12

      function sesh-sessions() {
        {
        exec </dev/tty
        exec <&1
        local session
        session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
        [[ -z "$session" ]] && return
        sesh connect $session
        }
      }

      zle     -N             sesh-sessions
      bindkey -M emacs '\es' sesh-sessions
      bindkey -M vicmd '\es' sesh-sessions
      bindkey -M viins '\es' sesh-sessions

      #Autosuggest config
      export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#3b8af7, bg=bold,underline"
      bindkey '^ ' autosuggest-accept
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
}
