# /Users/ven/dotfiles/nix/hosts/linux/system/aliases-linux.nix
#
# LINUX: ALIASES
# Provides Linux-specific path aliases.
# Ensures shared alias logic always has valid values.
# ============================================================

{ ... }:

let
  home = "/home/ven";
in
{
  _module.args.aliasesLinux = {

    # --- Core directories ----
    home       = home;
    configDir  = "${home}/.config";
    cacheDir   = "${home}/.cache";
    dataDir    = "${home}/.local/share";

    # --- Dotfiles ----
    dotfiles   = "${home}/dotfiles";

    # --- Containers / backups (future-safe) ---
    containers = "${home}/containers";
    backups    = "${home}/backups";

    # --- Applications root (Linux variant) ---
    applicationsRoot = "${home}/Applications";
  };
}
