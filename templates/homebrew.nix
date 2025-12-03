# /Users/ven/dotfiles/nix/hosts/darwin/services/homebrew.nix
#
# DARWIN: HOMEBREW GLUE
# Wires nix-homebrew engine, Homebrew PATHs and packages.
# Imports:
#   - nix-homebrew module (engine provider)
#   - brew-paths.nix for PATH integration
#   - brew-pkgs.nix for taps, brews and casks
# ============================================================

{ inputs, ... }:

{
  # ------------------------------------------------------------
  # MODULE IMPORTS
  # Homebrew engine, PATHs and package definitions.
  # ------------------------------------------------------------
  imports = [
    # ------ Nix Homebrew engine provider ------
    inputs.nix-homebrew.darwinModules.nix-homebrew

    # ------ Homebrew PATH integration ------
    ./brew-paths.nix

    # ------ Homebrew packages (taps, brews, casks) ------
    ./brew-pkgs.nix
  ];

  # ------------------------------------------------------------
  # NIX-HOMEBREW CORE SETTINGS
  # Base nix-homebrew integration for Homebrew management.
  # ------------------------------------------------------------
  nix-homebrew = {
    enable        = true;
    user          = "ven";
    enableRosetta = false;
    autoMigrate   = true;
  };
}
