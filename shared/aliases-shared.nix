# /Users/ven/dotfiles/nix/shared/aliases-shared.nix
#
# SHARED: PATH ALIASES
# Provides fallback-safe merging of Darwin and Linux aliases.
# Ensures missing OS aliases never cause module evaluation errors.
# ============================================================

{ lib, aliasesDarwin ? {}, aliasesLinux ? {}, ... }:

let
  # Select OS-specific home safely without evaluating missing attributes.
  osHome =
    if aliasesDarwin ? home then aliasesDarwin.home
    else if aliasesLinux ? home then aliasesLinux.home
    else "/home/ven";   # final fallback so Nix never dies
in
{
  _module.args.aliasesShared =

    # Merge Darwin + Linux aliases (whichever exist)
    aliasesDarwin // aliasesLinux // {

      # --- Portable directores ---
      home      = osHome;
      configDir = "${osHome}/.config";
      cacheDir  = "${osHome}/.cache";
      dataDir   = "${osHome}/.local/share";

      # --- App install root ---
      appsRoot =
        if aliasesDarwin ? applicationsRoot then aliasesDarwin.applicationsRoot
        else if aliasesLinux ? applicationsRoot then aliasesLinux.applicationsRoot
        else "/Applications";

    };
}
