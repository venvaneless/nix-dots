# /Users/ven/dotfiles/nix/shared/home.nix
#
# SHARED: USER HOME SETTINGS
# Provides shared user-level configuration for Home Manager:
#   - session variables
#   - user environment overrides
# Does NOT include Home Manager engine integration.
# ============================================================


{ config, pkgs, ... }:

{
  # ------------------------------------------------------------
  # HOME MANAGER PROGRAM
  # Enables `home-manager` command inside user session.
  # ------------------------------------------------------------
  programs.home-manager.enable = true;

  # ------------------------------------------------------------
  # SESSION VARIABLES
  # Shared environment variables for all systems.
  # ------------------------------------------------------------
  home.sessionVariables = {
    EDITOR = "nvim";
    LANG   = "en_US.UTF-8";
  };
}
