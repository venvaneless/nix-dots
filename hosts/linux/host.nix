# /Users/ven/dotfiles/nix/hosts/linux/host.nix
#
# LINUX: HOST CONFIG
# NixOS system configuration glue with integrated Home Manager.
# Minimal starter configuration for the "linux" host.
# ============================================================

{ config, pkgs, lib, home-manager, ... }:

{
  # ------------------------------------------------------------
  # MODULE IMPORTS
  # Core modules for NixOS system and Home Manager.
  # ------------------------------------------------------------
  imports = [
    # ------ Home Manager engine ------
    home-manager.nixosModules.home-manager

    # ------ Integrated HM config ------
    ./hm-in.nix

    # ------ System-level config ------
    ./system.nix
  ];

  # ------------------------------------------------------------
  # SYSTEM IDENTITY
  # Primary user and state version.
  # ------------------------------------------------------------
  users.users.ven = {
    isNormalUser = true;
    home         = "/home/ven";
    extraGroups  = [ "wheel" ];
  };

  system.stateVersion = "24.11";
}
