{ ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "find ~+ -type f";
    tmux = {
      enableShellIntegration = true;
      shellIntegrationOptions = [ "-h 50%" "-w 30%" ];
    };
  };
}
