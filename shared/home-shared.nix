# /Users/ven/dotfiles/nix/shared/home-shared.nix
#
# HOME-MANAGER: SHARED ROOT MODULE
# ============================================================
# Contains ONLY platform-agnostic Home Manager configuration:
#   - user identity
#   - home directory (from shared paths)
#   - shared HM defaults
#   - shared environment variables
#
# Does NOT import:
#   - zsh modules
#   - fzf, starship
#   - apps
#   - OS-specific modules
# ============================================================

{ config, pkgs, lib, sharedPaths, ... }:

let
  isLinux     = pkgs.stdenv.hostPlatform.isLinux;
  isDarwin    = pkgs.stdenv.hostPlatform.isDarwin;
  unsupported = builtins.abort "Unsupported platform for home.homeDirectory";
in
{
	
  # ---- USER DEFINITION (ALL MACHINES) ----
  home.username      = "ven";
  home.homeDirectory =
      if isLinux then "/home/ven" else
      if isDarwin then "/Users/ven"
      else unsupported;
  home.stateVersion  = "24.11";

  # ---- CORE HOME MANAGER ----
  programs.home-manager.enable = true;

  # ---- SHARED BASIC PROGRAMS ----
  programs.git.enable = true;
  programs.ssh.enable = true;

  # ---- SESSION PATH FOR BOTH SYSTEMS ----
  home.sessionPath = [
    "${sharedPaths.home}/.local/bin"
  ];

  # ---- SHARED ENVIRONMENT ----
  home.sessionVariables = {
    EDITOR = "nvim";
    LANG   = "en_US.UTF-8";
  };
}
