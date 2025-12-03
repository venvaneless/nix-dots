# /Users/ven/dotfiles/nix/hosts/linux/hm-in.nix
#
# LINUX: HOME MANAGER (INTEGRATED)
# Home Manager configuration for the user "ven" under NixOS.
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
    home.homeDirectory = "/home/ven";
    home.stateVersion  = "25.11";
  };
}
