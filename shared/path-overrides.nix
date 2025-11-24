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
  # Import all three path modules. They only define string options,
  # so it's harmless if some paths don't exist on a given host.
  imports = [
    ./paths-shared.nix
    ../hosts/darwin/paths-darwin.nix
    ../hosts/linux/paths-linux.nix
  ];

  # Merge all path namespaces into one public API.
  config.sharedPaths =
    (config.pathsShared or {})
    // (config.pathsDarwin or {})
    // (config.pathsLinux  or {});
}
