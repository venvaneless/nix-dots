# /Users/ven/dotfiles/nix/flake.nix
#
# FLAKE ROOT
# Main entry for all Nix configurations.
# Provides:
#   - Darwin with integrated Home Manager
#   - NixOS with integrated Home Manager
#   - Standalone Home Manager for Darwin and Linux
# ============================================================

{
  description = "Ven’s setup";

  nixConfig.allow-dirty = true;

  # ------------------------------------------------------------
  # INPUTS
  # Sources for nixpkgs, nix-darwin, Home Manager and nix-homebrew.
  # ------------------------------------------------------------
  inputs = {
    nixpkgs.url       = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin.url        = "github:LnL7/nix-darwin";
    home-manager.url  = "github:nix-community/home-manager";
    nix-homebrew.url  = "github:zhaofengli/nix-homebrew";

    # Home Manager follows global nixpkgs input.
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  # ------------------------------------------------------------
  # OUTPUTS
  # System and Home Manager configurations per machine.
  # ------------------------------------------------------------
  outputs = inputs@{ self, nixpkgs, darwin, home-manager, nix-homebrew, ... }:
  let
    # ------ System identifiers ------
    systemDarwin = "aarch64-darwin";
    systemLinux  = "x86_64-linux";

    # ------ Base package sets ------
    pkgsDarwin = import nixpkgs { system = systemDarwin; };
    pkgsLinux  = import nixpkgs { system = systemLinux; };
  in
  {

    # ------------------------------------------------------------
    # DARWIN: INTEGRATED HOME MANAGER
    # Nix-darwin system with embedded Home Manager.
    # ------------------------------------------------------------
    darwinConfigurations.macbook = darwin.lib.darwinSystem {
      system = systemDarwin;

      # ------ Extra arguments for Darwin modules ------
      specialArgs = {
        inherit inputs home-manager nix-homebrew;
      };

      # ------ Main Darwin module ------
      modules = [
        ./hosts/darwin/host.nix
      ];
    };

    # ------------------------------------------------------------
    # LINUX: INTEGRATED HOME MANAGER
    # NixOS system with embedded Home Manager.
    # ------------------------------------------------------------
    nixosConfigurations.linux = nixpkgs.lib.nixosSystem {
      system = systemLinux;

      specialArgs = {
        inherit inputs home-manager;
      };

      modules = [
        ./hosts/linux/host.nix
      ];
    };

    # ------------------------------------------------------------
    # STANDALONE HOME MANAGER
    # HM-only configs for Darwin and Linux.
    # ------------------------------------------------------------
    homeConfigurations = {

      # ------ Darwin standalone HM ------
      ven-darwin = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsDarwin;

        extraSpecialArgs = {
          inherit inputs;
        };

        modules = [
          ./hosts/darwin/hm-out.nix
        ];
      };

      # ------ Linux standalone HM ------
      ven-linux = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsLinux;

        extraSpecialArgs = {
          inherit inputs;
        ];

        modules = [
          ./hosts/linux/hm-out.nix
        ];
      };
    };

    # ------------------------------------------------------------
    # FLAKE APPS
    # Small helper commands per system.
    # ------------------------------------------------------------
    apps.${systemDarwin} = {
      # --- darwin-rebuild helper ---
      darwin-rebuild = {
        type = "app";
        program = "${darwin.packages.${systemDarwin}.darwin-rebuild}/bin/darwin-rebuild";
      };
    };

    apps.${systemLinux} = { };
  };
}
