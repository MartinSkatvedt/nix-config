{ pkgs, ... }:

{
  home.file.".config/1Password/ssh/agent.toml" = {
    source = ../config/1Password/ssh/agent.toml;
  };

}
