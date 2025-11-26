# /Users/ven/dotfiles/nix/hosts/darwin/system/paths-darwin.nix
#
# DARWIN: SYSTEM PATHS
# Adds system-wide PATH entries based on aliasesShared.
# This module is Darwin-only and used by nix-darwin.
# ============================================================

{ aliasesShared, lib, pkgs, ... }:

let
  sp = aliasesShared;
in

{
	brewPrefix = "/opt/homebrew";
		
  environment.systemPath = [
    # ---- Homebrew ----
    
    "${sp.brewPrefix}/bin"
    "${sp.brewPrefix}/sbin"

    # ---- System bin ----
    "/usr/local/bin"
    "/usr/local/sbin"

    # ---- Docker CLI ----
    sp.dockerBin
    sp.dockerPluginsDir

    # ---- ZED CLI ----
    "${sp.applicationsProgramming}/Zed.app/Contents/MacOS"

    # ---- NIX PROFILES ----
    "/nix/var/nix/profiles/default/bin"
  ];
}
