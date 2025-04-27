{
  description = "My NixOS configuration!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kolide-launcher = {
      url = "github:/kolide/nix-agent";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    opnix = { url = "github:brizzbuzz/opnix/main"; };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, kolide-launcher, opnix, ... }:
    let

      userSettings = {
        username = "martin";
        dotfilesDir = "~/.dotfiles"; # absolute path of the local repo
        dotfilesDirAbsolute = "/home/martin/.dotfiles";
        git = {
          userName = "Martin Skatvedt";
          userEmail = "martin.skatvedt@disruptive-technologies.com";
          signingKey =
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF7ypPYl6R+y3Q65sCe3XHupmDCZgr/TZ9wKevZfCVuh";
        };
      };

      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

    in {
      nixosConfigurations = {
        yoshi = lib.nixosSystem {
          inherit system;
          inherit pkgs;
          modules = [
            opnix.nixosModules.default
            ./configuration.nix
            kolide-launcher.nixosModules.kolide-launcher
          ];
          specialArgs = {
            inherit inputs;
            inherit userSettings;
          };
        };
      };
      homeConfigurations = {
        martin = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ opnix.homeManagerModules.default ./home.nix ];
          extraSpecialArgs = { inherit userSettings; };
        };
      };
    };
}
