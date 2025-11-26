# /Users/ven/dotfiles/nix/hosts/darwin/hm-out.nix
#
# DARWIN: HOME MANAGER (STANDALONE)
# Standalone Home Manager configuration for "ven" on macOS.
# Used via flake homeConfigurations.ven-darwin.
# ============================================================

{ lib, ... }:

{
  # ------------------------------------------------------------
  # HOME MANAGER USER
  # Identity and base HM configuration for ven.
  # ------------------------------------------------------------
  home.username      = "ven";
  home.homeDirectory = "/Users/ven";
  home.stateVersion  = "25.11";

  # ------ Shared HM settings ------
  imports = [
    ../../shared/home.nix
  ];
}
