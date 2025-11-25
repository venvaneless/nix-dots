# /Users/ven/dotfiles/nix/shared/path-overrides.nix
#
# PATH OVERRIDES (Unified, non-recursive)
# ============================================================
# Loads:
#   - shared paths (paths-shared.nix)
#   - Darwin paths (paths-darwin.nix)
#   - Linux paths (paths-linux.nix)
#
# Exposes everything under:
#   config.sharedPaths.<name>
# ============================================================

{ config, lib, ... }:

  # ------------------------------------------------------------
  # OPTION DECLARATIONS
  # ------------------------------------------------------------
  # These MUST be declared before any module assigns:
  #   config.pathsShared
  #   config.pathsDarwin
  #   config.pathsLinux
  #   config.sharedPaths
  #
  # Without this, you get:
  #   “The option `pathsDarwin` does not exist”
  #   “The option `pathsLinux` does not exist”
  #   “sharedPaths missing”
  # ------------------------------------------------------------
{
  options = {
    pathsShared = lib.mkOption { type = lib.types.attrs; default = {}; };
    pathsDarwin = lib.mkOption { type = lib.types.attrs; default = {}; };
    pathsLinux  = lib.mkOption { type = lib.types.attrs; default = {}; };
    sharedPaths = lib.mkOption { type = lib.types.attrs; default = {}; };
  };

    # ------------------------------------------------------------
    # ---- IMPORTS ----
    # Load all modules.
    # Only one will define pathsDarwin or pathsLinux.
    # ------------------------------------------------------------
  
  imports = [
    ./paths-shared.nix
    ../hosts/darwin/paths-darwin.nix
    ../hosts/linux/paths-linux.nix
  ];

  # ------------------------------------------------------------
  # ---- NAMESPACES ----
  # Merge namespaces without conditions or rewriting.
  # ------------------------------------------------------------
  config.sharedPaths =
    config.pathsShared
    // config.pathsDarwin
    // config.pathsLinux;
}
