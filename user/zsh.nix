{ pkgs, ... }:

{

  home.packages = with pkgs; [ zsh-powerlevel10k ];

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
