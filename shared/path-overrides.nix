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

  # ---- IMPORTS ----
  # ------------------------------------------------------------
  imports = [
    ./paths-shared.nix
    ../hosts/darwin/paths-darwin.nix
    ../hosts/linux/paths-linux.nix
  ];

  # ---- PATH DEFINITIONS ----
  # Now we restrict definitions using mkIf.
  # This is the SAFE way to do per-OS logic.
  # ------------------------------------------------------------
  config = {
    pathsDarwin = lib.mkIf (config.system == "aarch64-darwin") config.pathsDarwin;
    pathsLinux  = lib.mkIf (config.system == "x86_64-linux")  config.pathsLinux;

 # ---- NAMESPACES ----
  # This produces:
  #   config.sharedPaths.<variable>
  #
  # On macOS:
  #   sharedPaths = pathsShared // pathsDarwin
  #
  # On Linux:
  #   sharedPaths = pathsShared // pathsLinux
  #
  # On both:
  #   sharedPaths is always defined, safe to reference anywhere.
  # ------------------------------------------------------------
    sharedPaths =
      (config.pathsShared or {})
      // (lib.optionalAttrs (config.system == "aarch64-darwin") config.pathsDarwin)
      // (lib.optionalAttrs (config.system == "x86_64-linux")  config.pathsLinux);
  };
}
