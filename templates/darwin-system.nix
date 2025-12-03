# /Users/ven/dotfiles/nix/hosts/darwin/system.nix
#
# DARWIN: SYSTEM CONFIG
# System-level macOS configuration:
#   - Homebrew glue module
#   - Firewall and macOS defaults (Dock, Finder, UI)
# ============================================================

{ config, pkgs, lib, inputs, ... }:

{
  # ------------------------------------------------------------
  # MODULE IMPORTS
  # System modules for Homebrew and services.
  # ------------------------------------------------------------
  imports = [
    # ------ Homebrew glue (engine + paths + packages) ------
    ./services/homebrew.nix
  ];

  # ------------------------------------------------------------
  # FIREWALL
  # Application firewall for incoming connections.
  # ------------------------------------------------------------
  networking.applicationFirewall.enable = true;

  # ------------------------------------------------------------
  # MACOS DEFAULTS
  # Dock, Finder and global UI preferences.
  # ------------------------------------------------------------
  system.defaults = {

    # ------ Dock settings ------
    dock = {
      autohide = true;
      tilesize = 48;
    };

    # ------ Finder settings ------
    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle   = "Nlsv";
      NewWindowTarget        = "Home";
      ShowPathbar            = true;
    };

    # ------ Global UI settings ------
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      AppleWindowTabbingMode = "always";
    };

    # ------ Firewall defaults (ALF) ------
    alf = {
      globalstate = 1;
    };
  };
}
