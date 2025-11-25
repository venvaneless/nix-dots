# /Users/ven/dotfiles/nix/hosts/darwin/host-darwin.nix
{ config, pkgs, lib, inputs, pathsDarwin, pathsShared, ... }:

{
  # ------------------------------------------------------------
  # SYSTEM USER + STATE VERSION
  # ------------------------------------------------------------
  system.primaryUser  = "ven";
  system.stateVersion = lib.mkForce 6;

  # Darwin user must exist on macOS already
  users.users.ven.home = "/Users/ven";

  # ------------------------------------------------------------
  # CORE NIX SETTINGS
  # ------------------------------------------------------------
  nix.optimise.automatic = true;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];

    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:…"
    ];

    build-users-group = "nixbld";
  };

  # ------------------------------------------------------------
  # TOP-LEVEL MODULE IMPORTS
  # ------------------------------------------------------------
  imports = [
    # Integrated Home Manager
    inputs.home-manager.darwinModules.home-manager

    # Path alias injection (Darwin + shared)
    ./system/paths-darwin.nix
    ../../shared/paths-shared.nix

    # System modules
    ./system/system.nix
  ];

  # ------------------------------------------------------------
  # HOME MANAGER CONFIG (INTEGRATED)
  # ------------------------------------------------------------
  home-manager.useGlobalPkgs   = true;
  home-manager.useUserPackages = true;

  home-manager.users.ven = {
    imports = [
    	./hosts/darwin/system/paths-darwin.nix
    ];

    # If you want extra HM modules per user, add here.
  };
}
