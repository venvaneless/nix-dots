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

{
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
  options = {

    pathsShared = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Shared cross-platform path variables.";
    };

    pathsDarwin = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "macOS-specific path variables.";
    };

    pathsLinux = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Linux-specific path variables.";
    };

    sharedPaths = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Merged path namespace available to all modules on this host.";
    };
  };


  # ---- PATH DEFINITIONS ----
  # ------------------------------------------------------------
  imports =
    [
      ./paths-shared.nix
    ]
    ++ lib.optional config._module.system == "aarch64-darwin" ../hosts/darwin/paths-darwin.nix
    ++ lib.optional config._module.system == "x86_64-linux"  ../hosts/linux/paths-linux.nix;


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
  config.sharedPaths =
    (config.pathsShared or {})
    // (config.pathsDarwin or {})
    // (config.pathsLinux  or {});
}
