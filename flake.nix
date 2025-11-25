# /Users/ven/dotfiles/nix/flake.nix

{
  description = "Ven's modular multi-host Darwin + NixOS setup";

  nixConfig.allow-dirty = true;

  inputs = {
    nixpkgs.url       = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin.url        = "github:LnL7/nix-darwin";
    home-manager.url  = "github:nix-community/home-manager";
    nix-homebrew.url  = "github:zhaofengli/nix-homebrew";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, nix-homebrew, ... }:
  let
    forSystem = system: import nixpkgs { inherit system; };
  in
  {
    # ============================================================
    # DARWIN HOST (nix-darwin + integrated Home Manager)
    # ============================================================

    darwinConfigurations = {
      macbook = darwin.lib.darwinSystem {
        system = "aarch64-darwin";

        specialArgs = {
          inherit inputs home-manager nix-homebrew;
        };

        modules = [
       		./shared/path-overrides.nix
        	./shared/paths-shared.nix
         	./hosts/darwin/paths-darwin.nix
          
          ./hosts/darwin/host-darwin.nix
          ./hosts/darwin/home-darwin.nix
        ];
      };
    };

    # ============================================================
    # NIXOS HOST (NixOS + integrated Home Manager)
    # ============================================================

    nixosConfigurations = {
      linux = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs home-manager;
        };

        modules = [
       		./shared/path-overrides.nix
        	./shared/paths-shared.nix
         	./hosts/linux/paths-linux.nix
        	
          
          ./hosts/linux/host-linux.nix
          ./hosts/linux/home-linux.nix
        ];
      };
    };

    # No standalone HM. No other outputs.
    apps = { };
  };
}
