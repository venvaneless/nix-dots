# /Users/ven/dotfiles/nix/hosts/linux/hm-out.nix
#
# LINUX: HOME MANAGER (STANDALONE)
# Standalone Home Manager configuration for "ven".
# Used via flake homeConfigurations.ven-linux.
# ============================================================

{ lib, ... }:

{
  # ------------------------------------------------------------
  # HOME MANAGER USER
  # Identity and base HM configuration for ven.
  # ------------------------------------------------------------
  home.username      = "ven";
  home.homeDirectory = "/home/ven";
  home.stateVersion  = "25.11";

  # ------ Shared HM settings ------
  imports = [
    ../../shared/home.nix
  ];
}
