# /Users/ven/dotfiles/nix/hosts/darwin/services/brew-paths.nix
#
# DARWIN: HOMEBREW PATHS
# Exposes Homebrew binary paths in the system PATH:
#   - /opt/homebrew/bin
#   - /opt/homebrew/sbin
# ============================================================

{ ... }:

{
  # ------------------------------------------------------------
  # SYSTEM PATH
  # Adds Homebrew binaries to environment.systemPath.
  # ------------------------------------------------------------
  environment.systemPath = [
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
  ];
}
