{ pkgs, ... }:

{

  home.packages = with pkgs; [ zoxide sesh ];

  # Sesh config files
  home.file.".config/sesh/" = {
    source = ../../config/sesh;
    recursive = true;
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    clock24 = true;
    sensibleOnTop = true;

    plugins = with pkgs.tmuxPlugins; [
      tmux-powerline
      {
        plugin = power-theme;
        extraConfig = "set -g @tmux_power_theme 'colour4'";
      }
    ];

    extraConfig = ''
            # Set the default terminal terminfo
            set -g default-terminal "tmux-256color"
            # True colour support
            set -as terminal-overrides ",xterm*:Tc"

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
      		--bind 'ctrl-g:change-prompt(⚙️   )+reload(sesh list -c)' \
      		--bind 'ctrl-d:execute(tmux kill-session -t {})+change-prompt(⚡  )+reload(sesh list)'
          )\""
    '';
  };
}
