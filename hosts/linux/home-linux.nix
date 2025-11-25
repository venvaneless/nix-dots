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
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.ven = {
    imports = [
      .../../../shared/system-shared.nix
    ];

    home.sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
    ];
  };
}
