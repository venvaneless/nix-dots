# /Users/ven/dotfiles/nix/hosts/linux/system/aliases-linux.nix
#
# LINUX: ALIASES
# Provides:
#   - Basic alias structure for Linux.
#   - Ensures shared alias module never breaks.
#   - Adds core paths: home, dotfiles, config, cache, data.
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

    # --- Applications root (Linux equivalent) ---
    applicationsRoot = "${home}/Applications";  # you can rename later

    # --- Containers, backups (future-safe) ---
    containers = "${home}/containers";
    backups    = "${home}/backups";
  };
}
