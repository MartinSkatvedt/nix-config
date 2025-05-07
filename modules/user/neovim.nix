{ pkgs, ... }:

{

  home.packages = with pkgs;
    [
      ripgrep # for Telescope live grep
    ];

  home.file.".config/nvim/" = {
    source = ../../config/nvim;
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
  };

}
