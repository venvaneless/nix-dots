# /Users/ven/dotfiles/nix/hosts/darwin/system/homebrew.nix
#
# HOMEBREW: DECLARATIVE PACKAGES
# ============================================================
# Lists brews and casks managed by the nix-darwin Homebrew
# module. nix-homebrew bootstrap and core config live in
# flake.nix inline modules.
# ============================================================

{ aliasesShared, ... }:

{
  homebrew = {
    enable = true;

    # Auto-update brews and casks.
    global.autoUpdate = true;

    # Remove packages that are no longer declared.
    onActivation.cleanup = "uninstall";

    # ----------------------------------------------------------
    # BREWS
    # ----------------------------------------------------------
    brews = [
      "nginx"
    ];

    # ----------------------------------------------------------
    # CASKS
    # ----------------------------------------------------------
    casks = [
      {
        name = "ungoogled-chromium";
        # Uses aliasesShared.appsRoot from aliases-shared.nix
        args = { appdir = aliasesShared.appsRoot; };
      }
    ];
  };
}
