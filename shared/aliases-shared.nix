# SHARED: ALIASES
# Cross-platform path helpers.
# Consumes Darwin + Linux home aliases WITHOUT REQUIRING BOTH.
# ============================================================

{ aliasesDarwin ? {}, aliasesLinux ? {}, ... }:

let
  # ---- OS-specific home paths ----
  osHome =
    if aliasesDarwin?mHome then aliasesDarwin.mHome
    else if aliasesLinux?nHome then aliasesLinux.nHome
    else "/UNKNOWN-HOME";
in
{
	# Merge Darwin + Linux aliases
  _module.args.aliasesShared = {
    home = osHome;
    
    # --- Portable directores ---
    configDir = "${osHome}/.config";
    cacheDir  = "${osHome}/.cache";
    dataDir   = "${osHome}/.local/share";

    # ---- dotfiles ----
    dotfiles =
      aliasesDarwin.dotfiles or
      aliasesLinux.dotfiles or
      "${osHome}/dotfiles";
      
    # --- App install root ---
    appsRoot =
      aliasesDarwin.applicationsRoot or
      aliasesLinux.applicationsRoot or
      "/Applications";
  };
}
