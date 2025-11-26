# /Users/ven/dotfiles/nix/hosts/darwin/host.nix
#
# DARWIN: HOST CONFIG
# Main glue module for macOS:
#   - System identity (user, state version, hostname)
#   - Core Nix settings
#   - Shell + defaults
#   - AFTER THAT: all module imports (HM, system.nix, brew, paths, aliases)
# ============================================================

{ config, pkgs, lib, inputs, home-manager, ... }:

{
  # ------------------------------------------------------------
  # SYSTEM IDENTITY
  # Must be defined BEFORE imports for darwinSystem.
  # ------------------------------------------------------------
  system.primaryUser = "ven";
  system.stateVersion = lib.mkForce 6;

  users.users.ven = {
    home  = "/Users/ven";
    shell = pkgs.zsh;
  };

  networking.hostName = "Vens-Macbook";

  # ------------------------------------------------------------
  # NIX CORE SETTINGS
  # Must also be defined BEFORE loading Home Manager.
  # ------------------------------------------------------------
  nix = {
    optimise.automatic = true;

    settings = {
      experimental-features = [ "nix-command" "flakes" ];

      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:JskYNL0Y9RxrK2AQcJQO4gp4fJu7NDZfCFeiyPu7o2w="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];

      build-users-group = "nixbld";
    };
  };

  # ------------------------------------------------------------
  # SYSTEM SHELL
  # ------------------------------------------------------------
  programs.zsh.enable = true;

  # ------------------------------------------------------------
  # MACOS DEFAULTS
  # ------------------------------------------------------------
  system.defaults = {
    dock = {
      autohide = true;
      tilesize = 48;
    };

    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle   = "Nlsv";
      NewWindowTarget        = "Home";
      ShowPathbar            = true;
    };

    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      AppleWindowTabbingMode = "always";
    };

    alf = {
      globalstate = 1;
    };
  };

  networking.applicationFirewall.enable = true;

  # ------------------------------------------------------------
  # MODULE IMPORTS
  # Load all system + HM modules AFTER system identity is known.
  # ------------------------------------------------------------
  imports = [
    # ---- Home Manager engine ----
    home-manager.darwinModules.home-manager

    # ---- Integrated HM config ----
    ./hm-in.nix

    # ---- System-level config ----
    ./system.nix
  ];
}
