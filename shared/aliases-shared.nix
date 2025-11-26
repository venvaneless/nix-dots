# /Users/ven/dotfiles/nix/shared/aliases-shared.nix
#
# SHARED: PATH ALIASES
# Aggregates platform-specific alias maps (Darwin + Linux)
# into a shared aliasesShared set.
# Requires either aliasesDarwin.home or aliasesLinux.home.
# ============================================================

{ aliasesDarwin ? {}, aliasesLinux ? {}, ... }:

let
  baseHome = aliasesDarwin.home or aliasesLinux.home or "/nonexistent";
in {
  _module.args.aliasesShared =
    aliasesDarwin // aliasesLinux // {
      configDir = "${baseHome}/.config";
      cacheDir  = "${baseHome}/.cache";
      dataDir   = "${baseHome}/.local/share";
      appsRoot  = aliasesDarwin.applicationsRoot
                  or aliasesLinux.applicationsRoot
                  or "/Applications";
    };
}
