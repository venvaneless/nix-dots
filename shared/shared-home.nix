# /Users/ven/dotfiles/nix/shared/shared-home.nix
#
# SHARED: HOME MANAGER USER SETTINGS
# Shared user-level configuration for Home Manager.
# Does not define identity (home.username, home.homeDirectory).
# Only adds environment variables and future shared settings.
# ============================================================

{ ... }:

{
  # ------------------------------------------------------------
  # SESSION VARIABLES
  # ------------------------------------------------------------
  home.sessionVariables = {
    EDITOR = "nvim";
    LANG   = "en_US.UTF-8";
  };
}
