# /Users/ven/dotfiles/nix/hosts/linux/paths.nix
#
# LINUX: SYSTEM PATHS
# Extends environment.systemPath using hardcoded paths:
#   - /home/ven/.local/bin
#   - /home/ven/bin
# No shared aliases wired yet.
# ============================================================

{ ... }:

{
  # ------------------------------------------------------------
  # SYSTEM PATH
  # Minimal Linux PATH extensions for user-level binaries.
  # ------------------------------------------------------------
  environment.systemPath = [
    "/home/ven/.local/bin"
    "/home/ven/bin"
  ];
}
