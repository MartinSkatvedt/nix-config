{ userSettings, ... }:

{
  services.onepassword-secrets = {
    enable = true;
    users = [ userSettings.username ]; # Users that need secret access
    tokenFile = "/etc/opnix-token"; # Default location
    configFile = (userSettings.dotfilesDirAbsolute + "/config/secrets.json");
    outputDir = "/var/lib/opnix/secrets";
  };
}
