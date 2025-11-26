# /Users/ven/dotfiles/nix/shared/aliases-shared.nix
#
# SHARED: PATH ALIASES
# ------------------------------------------------------------
# Cross-platform helpers built from:
#   - _module.args.aliasesDarwin (macOS)
#   - _module.args.aliasesLinux  (Linux)
#
# Guarantees:
#   - aliasesShared.home is ALWAYS defined.
#   - configDir/cacheDir/dataDir always point to $HOME-based dirs.
#   - dotfiles and appsRoot fall back to sane defaults.
#
# Consumed by:
#   - flake.nix (inline HM / system blocks)
#   - hosts/*/system/paths-*.nix
#   - shared/shared-home.nix
# ------------------------------------------------------------

{ config, lib, ... }:

let
  # Pull per-OS alias maps from _module.args
  d = config._module.args.aliasesDarwin or { };
  l = config._module.args.aliasesLinux  or { };

  # Decide which "home" to use:
  #   - Prefer Darwin if present (on macOS builds).
  #   - Otherwise use Linux if present.
  #   - Fallback is a loud, obviously broken path.
  osHome =
    if d ? home then d.home
    else if l ? home then l.home
    else "/UNKNOWN-HOME";
in
{
  _module.args.aliasesShared =

    # Merge Darwin + Linux maps first.
    d // l // {

      # ---- Shared base paths ----
      # Canonical "home" for the active system.
      home = osHome;

      # XDG-like directories.
      configDir = d.configDir or (l.configDir or "${osHome}/.config");
      cacheDir  = d.cacheDir  or (l.cacheDir  or "${osHome}/.cache");
      dataDir   = d.dataDir   or (l.dataDir   or "${osHome}/.local/share");

      # ---- Dotfiles ----
      # Falls back to $HOME/dotfiles if not provided.
      dotfiles =
        d.dotfiles or
        l.dotfiles or
        "${osHome}/dotfiles";

      # ---- App install root ----
      # Darwin: /Applications
      # Linux:  $HOME/Applications
      appsRoot =
        d.applicationsRoot or
        l.applicationsRoot or
        "/Applications";
    };
}
