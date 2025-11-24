# /Users/ven/dotfiles/nix/hosts/darwin/system/homebrew.nix
#
# HOMEBREW: SYSTEM-LEVEL PACKAGE MANAGER
# ============================================================
# Provides:
#   - Homebrew bootstrapping via nix-homebrew
#   - Declarative Brew & Cask installation
#   - Automatic migration of existing brew setups
#   - Clean uninstall of removed packages
#
# This module is macOS-only and loaded by nix-darwin.
# ============================================================

{ config, nix-homebrew, ... }:

{
  # ------------------------------------------------------------
  # NIX-HOMEBREW BACKEND
  # ------------------------------------------------------------
  # 
  # ---- LOAD HOMEBREW ----
  # run declaratively under /opt/homebrew.
  imports = [
    nix-homebrew.darwinModules.nix-homebrew
  ];
  
  # ---- NIX-HOMEBREW ----
  nix-homebrew = {
    enable = true;
    user   = "ven";
    enableRosetta = false;

    # Auto-migrate existing
    autoMigrate = true;
  };


  # ------------------------------------------------------------
  # BREW & CASK MANAGEMENT
  # ------------------------------------------------------------
  # ---- BREW ----
  homebrew = {
    enable = true;

    # ---- UPDATE BREWS AND CASKS ----
    global.autoUpdate = true;

    # ----- UNINSTALL REMOVED ----
    onActivation.cleanup = "uninstall";

    # --- BREWS ---
    brews = [
      "nginx"
    ];

    # --- CASKS ---
    casks = [
      {
        name = "ungoogled-chromium";
        args = { appdir = config.sharedPaths.appsRoot; };
      }
    ];
  };
}