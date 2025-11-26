# /Users/ven/dotfiles/nix/hosts/darwin/services/brew-paths.nix
#
# DARWIN: HOMEBREW PATHS
# Adds Homebrew-related binaries to environment.systemPath:
#   - Homebrew bin/sbin from aliasesDarwin
#   - Global macOS paths
#   - User-local paths for convenience
# ============================================================

{ aliasesDarwin, ... }:

let
  sp = aliasesDarwin;
in
{
  # ------------------------------------------------------------
  # SYSTEM PATH
  # Ensures Homebrew and user-local tools are visible system-wide.
  # ------------------------------------------------------------
  environment.systemPath = [
    # ------ Homebrew prefix ------
    "${sp.brewPrefix}/bin"
    "${sp.brewPrefix}/sbin"

    # ------ Standard macOS paths ------
    "/usr/local/bin"
    "/usr/local/sbin"
    "/usr/bin"
    "/bin"
    "/usr/sbin"
    "/sbin"
    "/Library/Apple/usr/bin"

    # ------ Nix profiles ------
    "/nix/var/nix/profiles/default/bin"

    # ------ User-local convenience bins ------
    "${sp.home}/.local/bin"
    "${sp.home}/bin"
  ];
}
