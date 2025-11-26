# /Users/ven/dotfiles/nix/hosts/darwin/host-darwin.nix
#
# DARWIN: SYSTEM UI + PACKAGES
# ------------------------------------------------------------
# Pure nix-darwin system module:
#   - Dock, Finder, trackpad
#   - Networking, fonts
#   - System packages
#
# All user identity + HM wiring lives in flake.nix.
# ------------------------------------------------------------

{ config, pkgs, lib, inputs, ... }:

{
  # ------------------------------------------------------------
  # DOCK SETTINGS
  # ------------------------------------------------------------
  system.defaults.dock = {
    autohide     = true;  # Hide dock when not in use.
    show-recents = true;  # Show recent apps in dock.
    tilesize     = 65;    # Icon size.
  };

  # ------------------------------------------------------------
  # FINDER SETTINGS
  # ------------------------------------------------------------
  system.defaults.finder = {
    AppleShowAllExtensions = true;  # Show file extensions everywhere.
    ShowPathbar            = true;  # Show path bar at bottom.
    ShowStatusBar          = true;  # Show status bar (item counts, free space).
  };

  # ------------------------------------------------------------
  # TRACKPAD SETTINGS
  # ------------------------------------------------------------
  system.defaults.trackpad = {
    Clicking                     = true;  # Tap-to-click.
    TrackpadRightClick           = false; # No two-finger right-click (use corner).
    TrackpadCornerSecondaryClick = 2;     # Bottom-right corner secondary click.
  };

  # ------------------------------------------------------------
  # NETWORKING
  # ------------------------------------------------------------
  networking.wakeOnLan.enable = false;  # Disable WoL.

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
