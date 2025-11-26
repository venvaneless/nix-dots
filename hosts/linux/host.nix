# /Users/ven/dotfiles/nix/hosts/darwin/host.nix
#
# DARWIN: HOST CONFIG
# Glue module for macOS system, Home Manager and strict Nix settings.
# Holds only:
#   - Core Nix options required at host level
#   - Minimal user identity and shell
#   - All module imports for the Darwin system
# ============================================================

{ config, pkgs, lib, inputs, home-manager, ... }:

{
  # ------------------------------------------------------------
  # MODULE IMPORTS
  # Loads system modules and integrated Home Manager.
  # ------------------------------------------------------------
  imports = [
    # ------ Home Manager engine ------
    home-manager.darwinModules.home-manager

    # ------ Integrated HM config ------
    ./hm-in.nix

    # ------ System-level config ------
    ./system.nix
  ];

  # ------------------------------------------------------------
  # SYSTEM IDENTITY
  # Primary user, state version, home directory and hostname.
  # ------------------------------------------------------------
  system.primaryUser = "ven";
  system.stateVersion = lib.mkForce 6;

  users.users.ven.home = "/Users/ven";

  networking.hostName = "Vens-Macbook";

  # ------------------------------------------------------------
  # NIX CORE SETTINGS
  # Strict system-wide settings needed at host level.
  # ------------------------------------------------------------
  nix = {

    # ------ GC behavior ------
    optimise.automatic = true;

    # ------ Core settings ------
    settings = {
      # ---- CLI features ----
      experimental-features = [ "nix-command" "flakes" ];

      # ---- Substituters ----
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];

      # ---- Trusted keys ----
      trusted-public-keys = [
        "nix-community.cachix.org-1:JskYNL0Y9RxrK2AQcJQO4gp4fJu7NDZfCFeiyPu7o2w="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];

      # ---- System build users ----
      build-users-group = "nixbld";
    };
  };

  # ------------------------------------------------------------
  # SYSTEM SHELL
  # System-level zsh enabling and login shell.
  # ------------------------------------------------------------
  programs.zsh.enable = true;

  # --- Login shell for ven ---
  users.users.ven.shell = pkgs.zsh;
}
