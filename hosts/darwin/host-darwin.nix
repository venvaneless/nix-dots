# /Users/ven/dotfiles/nix/hosts/darwin/host-darwin.nix
#
# DARWIN: SYSTEM SETTINGS
# macOS-only system configuration:
#   - Dock, Finder and Trackpad preferences.
#   - Networking, fonts, and core system packages.
#   - No user-level HM config here.
# ============================================================

{ config, pkgs, lib, inputs, ... }:

{
  # ------------------------------------------------------------
  # DOCK SETTINGS
  # ------------------------------------------------------------
  system.defaults.dock = {
    autohide     = true;
    show-recents = true;
    tilesize     = 65;
  };

  # ------------------------------------------------------------
  # FINDER SETTINGS
  # ------------------------------------------------------------
  system.defaults.finder = {
    AppleShowAllExtensions = true;
    ShowPathbar            = true;
    ShowStatusBar          = true;
  };

  # ------------------------------------------------------------
  # TRACKPAD SETTINGS
  # ------------------------------------------------------------
  system.defaults.trackpad = {
    Clicking                     = true;
    TrackpadRightClick           = false;
    TrackpadCornerSecondaryClick = 2;
  };

  # ------------------------------------------------------------
  # NETWORKING
  # ------------------------------------------------------------
  networking.wakeOnLan.enable = false;

  # ------------------------------------------------------------
  # FONTS
  # ------------------------------------------------------------
  fonts.packages = [
    pkgs.jetbrains-mono
    pkgs.noto-fonts
  ];

  # ------------------------------------------------------------
  # SYSTEM PACKAGES
  # ------------------------------------------------------------
  environment.systemPackages = with pkgs; [
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
