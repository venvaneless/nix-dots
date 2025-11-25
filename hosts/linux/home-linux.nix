# /Users/ven/dotfiles/nix/hosts/linux/home-linux.nix
#
# HOME MANAGER (LINUX)
# ============================================================
# Standalone Home Manager module for Linux/NixOS.
# Loads shared HM config and Linux-only HM overrides.
# ============================================================

{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    # --- LINUX HOME-MANAGER ----
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    # - System pkgs
    # - HM user package
    useGlobalPkgs   = true;
    useUserPackages = true;

    # --- LINUX HOME-MANAGER MODULES HERE ----
    users.ven = {
      # Shared HM Module
      imports = [
        ../../../shared/home-shared.nix
      ];

      home.sessionPath = [
        "${config.home.homeDirectory}/.local/bin"
      ];
    };
  };
}
