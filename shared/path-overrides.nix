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

  # Merge all path namespaces into one public API.
  config.sharedPaths =
    (config.pathsShared or {})
    // (config.pathsDarwin or {})
    // (config.pathsLinux  or {});
}
