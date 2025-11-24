# /Users/ven/dotfiles/nix/shared/path-overrides.nix
#
# PATH OVERRIDES (Unified)
# ============================================================
# Loads:
#   - shared paths (paths-shared.nix)
#   - OS-specific paths (paths-darwin.nix or paths-linux.nix)
#
# Exposes everything under:
#   config.sharedPaths.<name>
# ============================================================

{ config, lib, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux  = pkgs.stdenv.isLinux;
in
{
  imports =
    [	./paths-shared.nix	]
    ++ lib.optional isDarwin ../hosts/darwin/paths-darwin.nix
    ++ lib.optional isLinux  ../hosts/linux/paths-linux.nix;

  # Merge shared + OS-specific into one namespace
  config.sharedPaths =
    (config.pathsShared or {})
    // (config.pathsDarwin or {})
    // (config.pathsLinux  or {});
}
