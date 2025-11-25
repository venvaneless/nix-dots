# /Users/ven/dotfiles/nix/shared/path-overrides.nix
#
# PATH OVERRIDES (Unified, non-recursive)
# ============================================================
# Declares:
#   - pathsShared  (home-based, cross-platform)
#   - pathsDarwin  (macOS only)
#   - pathsLinux   (Linux only)
#   - sharedPaths  (merged public API)
#
# Loads:
#   - paths-shared.nix      (HOME-relative paths)
#
# Host-specific files:
#   - hosts/darwin/paths-darwin.nix
#   - hosts/linux/paths-linux.nix
# are imported by flake.nix, not from here.
# ============================================================

{ config, lib, ... }:

{
  # ------------------------------------------------------------
  # OPTION DECLARATIONS
  # ------------------------------------------------------------
  options = {
    pathsShared = lib.mkOption {
      type    = lib.types.attrs;
      default = {};
    };

    pathsDarwin = lib.mkOption {
      type    = lib.types.attrs;
      default = {};
    };

    pathsLinux = lib.mkOption {
      type    = lib.types.attrs;
      default = {};
    };

    sharedPaths = lib.mkOption {
      type    = lib.types.attrs;
      default = {};
    };
  };

  # ------------------------------------------------------------
  # IMPORTS
  # Only shared HOME-relative paths.
  # Host-specific paths are provided by their own modules.
  # ------------------------------------------------------------
  imports = [
    ./paths-shared.nix
  ];

  # ------------------------------------------------------------
  # MERGE NAMESPACES
  # sharedPaths = pathsShared + host-specific
  # ------------------------------------------------------------
  config.sharedPaths =
    (config.pathsShared or {})
    // (config.pathsDarwin or {})
    // (config.pathsLinux  or {});
}
