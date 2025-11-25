# /Users/ven/dotfiles/nix/hosts/darwin/home-darwin.nix
#
# HOME MANAGER (DARWIN-INTEGRATED)
# ============================================================
# Makes Home Manager part of nix-darwin.
# Loads shared HM config and Darwin-only HM overrides.
# Shell modules (zsh, fzf, starship) are imported ONLY by zsh.nix.
# ============================================================

{ config, lib, inputs, ... }:

{
  imports = [
    # --- DARWIN HOME-MANAGER ----
    inputs.home-manager.darwinModules.home-manager
  ];
 
  
  home-manager = {
    # - System pkgs
    # - HM user package
    useGlobalPkgs   = true;
    useUserPackages = true;


    # --- DARWIN HOME-MANAGER MODULES HERE ----
    users.ven = {
      imports = [
        ../../../shared/home/system-shared.nix
      ];

      # --- DARWIN HOME-MANAGER PATH ----
      home.sessionPath = [
        "${config.home.homeDirectory}/.local/bin"
      ];
    };
  };
}
