# /Users/ven/dotfiles/nix/hosts/darwin/system/system.nix
#
# DARWIN: BASE SYSTEM CONFIGURATION
# ============================================================
# Provides core system-wide settings for macOS, including:
#   - Host identity (hostname)
#   - Core Nix configuration (flakes, caches, CLI settings)
#   - System state version
#   - System-level packages required by macOS only
#
# This file does *not* manage user-level packages or configs.
# Home Manager handles the user session.
# ============================================================

{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./sys-paths.nix
    # other system modules…
  ];

  # --- CORE SETTINGS ---
  # ------------------------------------------------------------
  nix.settings = {
    # flakes + new CLI
    experimental-features = [ "nix-command" "flakes" ];

    # store optimizations
    auto-optimise-store = true;

    # binary caches
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:…"
    ];

    build-users-group = "nixbld";
  };


  # --- HOST IDENTITY ---
  # ------------------------------------------------------------
  networking.hostName = "Vens-MacBook-Pro";


  # --- nix-daemon ---
  # Determinate manages Nix. Leave this disabled.
  nix.enable = false;


  # --- SHELL INTEGRATION ---
  # Safe because macOS already uses zsh. This only declares it.
  programs.zsh.enable = true;


  # --- SYSTEM STATE VERSION ---
  system.stateVersion = lib.mkForce 6;


  # --- DOCK ---
  system.defaults.dock = {
    autohide = true;
    show-recents = true;
    tilesize = 32;
  };


  # --- FINDER ---
  system.defaults.finder = {
    AppleShowAllExtensions = true;
    ShowPathbar = true;
    ShowStatusBar = true;
  };


  # --- TRACKPAD ---
  system.defaults.trackpad = {
    Clicking = true;
    TrackpadRightClick = false;
    TrackpadCornerSecondaryClick = 2;  # bottom-right click
  };


  # --- GARBAGE COLLECTOR ---
  nix.gc = {
    automatic = true;
    interval = "monthly";
    options = "--delete-older-than 30d";
  };


  # --- NETWORKING ---
  networking.wakeOnLan.enable = false;


  # --- FONTS ---
  fonts.fonts = [
    pkgs.jetbrains-mono
    pkgs.noto-fonts
  ];


  # --- SYSTEM PACKAGES ---
  environment.systemPackages = with pkgs; [
    # nix-darwin rebuild helper
    inputs.darwin.packages.${pkgs.system}.darwin-rebuild

    bashInteractive
    git-crypt

    mkcert
    nssTools

    nginx

    nixd
    nil
  ];
}
