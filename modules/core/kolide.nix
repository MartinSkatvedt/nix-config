{ inputs, ... }:

{

  environment.systemPackages = [ inputs.kolide-launcher ];

  environment.etc."kolide-k2/secret" = {
    mode = "0600";
    source = "/var/lib/opnix/secrets/kolide-k2/secret";
  };

  services.kolide-launcher.enable = true;
}
