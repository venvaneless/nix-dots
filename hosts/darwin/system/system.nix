# /Users/ven/dotfiles/nix/hosts/darwin/system/system.nix
{ config, pkgs, lib, inputs, ... }:

{
  # ------------------------------------------------------------
  # HOSTNAME
  # ------------------------------------------------------------
  networking.hostName = "Vens-MacBook-Pro";

  # Shell environment
  programs.zsh.enable = true;

  # ------------------------------------------------------------
  # DOCK SETTINGS
  # ------------------------------------------------------------
  system.defaults.dock = {
    autohide = true;
    show-recents = true;
    tilesize = 65;
  };

  # ------------------------------------------------------------
  # FINDER SETTINGS
  # ------------------------------------------------------------
  system.defaults.finder = {
    AppleShowAllExtensions = true;
    ShowPathbar = true;
    ShowStatusBar = true;
  };

  # ------------------------------------------------------------
  # TRACKPAD SETTINGS
  # ------------------------------------------------------------
  system.defaults.trackpad = {
    Clicking = true;
    TrackpadRightClick = false;
    TrackpadCornerSecondaryClick = 2;
  };

  # ------------------------------------------------------------
  # GARBAGE COLLECTOR (darwin-compatible schedule)
  # ------------------------------------------------------------
  nix.gc = {
    automatic = true;
    interval = {
      Weekday = 0;  # Sunday
      Hour = 3;
      Minute = 0;
    };
    options = "--delete-older-than 30d";
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
