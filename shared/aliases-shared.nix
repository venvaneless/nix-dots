# /Users/ven/dotfiles/nix/shared/aliases-shared.nix
#
# SHARED: PATH ALIASES
# Aggregates platform-specific alias maps (Darwin + Linux)
# into a shared aliasesShared set.
# Requires either aliasesDarwin.home or aliasesLinux.home.
# ============================================================

{ aliasesDarwin ? {}, aliasesLinux ? {}, ... }:

{
  _module.args.aliasesShared =
    aliasesDarwin // aliasesLinux // {
      # Extra portable dirs
      configDir = "${(aliasesDarwin.home or aliasesLinux.home)}/.config";
      cacheDir  = "${(aliasesDarwin.home or aliasesLinux.home)}/.cache";
      dataDir   = "${(aliasesDarwin.home or aliasesLinux.home)}/.local/share";

      # App root for casks (derives from platform aliases if present)
      appsRoot =
        aliasesDarwin.applicationsRoot or
        aliasesLinux.applicationsRoot or
        "/Applications";
    };
}
