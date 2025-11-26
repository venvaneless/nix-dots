# /Users/ven/dotfiles/nix/shared/home.nix
#
# SHARED: HOME MANAGER SETTINGS
# Common user-level configuration shared by all HM configs:
#   - Enable Home Manager program
#   - Shared environment variables
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
