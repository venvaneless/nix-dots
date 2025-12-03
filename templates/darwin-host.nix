# /Users/ven/dotfiles/nix/hosts/darwin/host.nix
#
# DARWIN: HOST CONFIG
# Glue module for macOS system, Home Manager and strict Nix settings.
# Mirrors the working order from your old index.nix.
# ============================================================

{ config, pkgs, lib, inputs, home-manager, ... }:

{
  # ------------------------------------------------------------
  # SYSTEM IDENTITY
  # Must be defined BEFORE imports.
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
  # Same as your working index.nix.
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
  # EXACT order from your working index.nix.
  # ------------------------------------------------------------
  imports = [
    # HM engine
    home-manager.darwinModules.home-manager

    # User HM config
    ./hm-in.nix

    # System config
    ./system.nix

    # Paths + aliases (same place as working index.nix)
    ./paths.nix
    ./aliases.nix

    # Brew (engine + pkgs + paths)
    ./services/homebrew.nix
  ];
}
