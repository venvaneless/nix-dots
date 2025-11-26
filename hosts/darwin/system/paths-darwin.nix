# /Users/ven/dotfiles/nix/hosts/darwin/system/paths-darwin.nix
#
# DARWIN: SYSTEM PATHS
# ------------------------------------------------------------
# Extends environment.systemPath using aliasesShared:
#   - Homebrew bin/sbin
#   - Standard macOS /usr/local paths
#   - Docker Desktop binaries
#   - Zed CLI
#   - Nix profile binaries
#
# Consumed only on Darwin, never on Linux.
# ------------------------------------------------------------

{ aliasesShared, lib, pkgs, ... }:

let
  sp = aliasesShared;
in
{
  environment.systemPath = [
    # ---- Homebrew ----
    "${sp.brewPrefix}/bin"
    "${sp.brewPrefix}/sbin"

    # ---- Standard macOS paths ----
    "/usr/local/bin"
    "/usr/local/sbin"

    # ---- Docker Desktop paths ----
    sp.dockerBin
    sp.dockerPluginsDir

    # ---- Zed CLI ----
    "${sp.applicationsProgramming}/Zed.app/Contents/MacOS"

    # ---- Nix profiles ----
    "/nix/var/nix/profiles/default/bin"
  ];
}
