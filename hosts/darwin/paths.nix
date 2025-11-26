# /Users/ven/dotfiles/nix/hosts/darwin/paths.nix
#
# DARWIN: SYSTEM PATHS
# Extends environment.systemPath using aliasesShared.
# Includes:
#   - Homebrew bin/sbin
#   - Standard macOS paths
#   - Docker Desktop binaries
#   - Zed CLI
#   - Nix profile binaries
#   - User-local bin for convenience
# ============================================================

{ aliasesShared, ... }:

let
  sp = aliasesShared;
in
{
  # ------------------------------------------------------------
  # SYSTEM PATH
  # Base PATH entries for system processes and shells.
  # ------------------------------------------------------------
  environment.systemPath = [
    # ------ Homebrew (explicit top entry) ------
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"

    # ------ Homebrew via aliases ------
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

    # ------ Docker Desktop paths ------
    sp.dockerBin
    sp.dockerPluginsDir

    # ------ Zed CLI ------
    "${sp.applicationsProgramming}/Zed.app/Contents/MacOS"

    # ------ Nix profiles ------
    "/nix/var/nix/profiles/default/bin"

    # --- User-local convenience bins ---
    "${sp.home}/.local/bin"
    "${sp.home}/bin"
  ];
}
