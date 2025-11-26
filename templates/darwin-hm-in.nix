# /Users/ven/dotfiles/nix/hosts/darwin/hm-in.nix
#
# DARWIN: HOME MANAGER (INTEGRATED)
# Home Manager configuration for the user "ven" under nix-darwin.
# Provides:
#   - HM identity (username, home, stateVersion)
#   - Shared user-level settings via shared/home.nix
# ============================================================

{ lib, ... }:

{
  # ------------------------------------------------------------
  # MODULE IMPORTS
  # Shared user-level Home Manager configuration.
  # ------------------------------------------------------------
  imports = [
    ../../shared/home.nix
  ];

  # ------------------------------------------------------------
  # HOME MANAGER CORE
  # Use system packages and per-user packages.
  # ------------------------------------------------------------
  home-manager.useGlobalPkgs   = true;
  home-manager.useUserPackages = true;

  # ------------------------------------------------------------
  # HOME MANAGER USER
  # Identity and base HM configuration for ven.
  # ------------------------------------------------------------
  home-manager.users.ven = {
    home.username      = "ven";
    home.homeDirectory = "/Users/ven";
    home.stateVersion  = "25.11";
  };
}
