{ pkgs, ... }:

{
  home.packages = with pkgs; [ _1password-cli _1password-gui ];

  home.file.".config/1Password/ssh/agent.toml" = {
    source = ../config/1Password/ssh/agent.toml;
  };
}
