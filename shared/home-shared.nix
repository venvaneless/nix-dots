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

{ config, pkgs, lib, ... }:

{
  # ---- USER DEFINITION (ALL MACHINES) ----
  home.username = "ven";
  home.homeDirectory = config.sharedPaths.home;
  home.stateVersion = "24.11";

  # ---- CORE HOME MANAGER ----
  programs.home-manager.enable = true;

  # ---- SHARED BASIC PROGRAMS ----
  programs.git.enable = true;
  programs.ssh.enable = true;

  # ---- SHARED ENVIRONMENT ----
  home.sessionVariables = {
    EDITOR = "nvim";
    LANG   = "en_US.UTF-8";
  };

  # No imports here — zsh.nix imports its own shell modules.
}
