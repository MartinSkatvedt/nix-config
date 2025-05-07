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

    hyprland = { url = "github:hyprwm/Hyprland"; };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    stylix = { url = "github:danth/stylix"; };

  };

  outputs =
    { self, nixpkgs, home-manager, kolide-launcher, opnix, stylix, ... }@inputs:
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

      systemSettings = {
        hostname = "yoshi";
        boot-loader = "systemd"; # systemd, grub (see modules/core/boot-loader)
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
            stylix.nixosModules.stylix
            opnix.nixosModules.default
            ./configuration.nix
            kolide-launcher.nixosModules.kolide-launcher
          ];
          specialArgs = {
            inherit inputs;
            inherit userSettings;
            inherit systemSettings;
          };
        };
      };
      homeConfigurations = {
        martin = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            stylix.homeManagerModules.stylix
            opnix.homeManagerModules.default
            ./home.nix
          ];
          extraSpecialArgs = {
            inherit inputs;
            inherit userSettings;
            inherit systemSettings;
          };
        };
      };
    };
}
