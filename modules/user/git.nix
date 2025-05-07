{ lib, pkgs, userSettings, ... }:

{

  programs.git = {
    enable = true;
    userName = userSettings.git.userName;
    userEmail = userSettings.git.userEmail;
    extraConfig = {
      gpg = { format = "ssh"; };
      "gpg \"ssh\"" = {
        program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      };
      commit = { gpgsign = true; };

      user = { signingKey = userSettings.git.signingKey; };

      "url \"git@bitbucket.org:\"" = { insteadof = "https://bitbucket.org/"; };
    };
  };
}
