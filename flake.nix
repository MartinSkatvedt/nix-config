{
  description = "Setup flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kolide-launcher = {
      url = "github:/kolide/nix-agent/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, kolide-launcher, ... }:
    let

      userSettings = {
        username = "martin";
        dotfilesDir = "~/.dotfiles"; # absolute path of the local repo
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
          modules = [ ./home.nix ];
          extraSpecialArgs = { inherit userSettings; };
        };
      };
    };
}
