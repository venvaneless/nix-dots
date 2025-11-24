# /Users/ven/dotfiles/nix/hosts/darwin/system/sys-paths.nix
#
# DARWIN: SYSTEM PATHS
# ============================================================

{ config, lib, pkgs, ... }:

let
  sp = config.sharedPaths;
in
{
  environment.systemPath = [
    # --- HOMEBREW ---
    "${sp.brewPrefix}/bin"
    "${sp.brewPrefix}/sbin"

    # --- STANDARD MAC PATHS ---
    "/usr/local/bin"
    "/usr/local/sbin"

    # --- DOCKER DESKTOP PATHS ---
    sp.dockerBin
    sp.dockerPlugins

    # --- ZED CLI ---
    "${sp.applicationsProductivity}/Zed.app/Contents/MacOS"

    # --- NIX PROFILES ---
    "/nix/var/nix/profiles/default/bin"
  ];
}
