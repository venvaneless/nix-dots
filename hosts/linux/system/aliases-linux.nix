# /Users/ven/dotfiles/nix/hosts/linux/system/aliases-linux.nix
#
# LINUX: PATH ALIASES
# ------------------------------------------------------------
# Minimal Linux alias set.
# Only provides Linux-native paths:
#   - Home, dotfiles, config/cache/data dirs
#   - Containers, backups
#   - Linux-specific Applications folder
#
# This file is only imported by Linux configs.
# Darwin never touches it.
#
# Exposed under _module.args.aliasesLinux.
# Shared alias module merges these with Darwin equivalents.
# ------------------------------------------------------------

{ ... }:

let
  home = "/home/ven";
in
{
  _module.args.aliasesLinux = {

    # ---- Base directories ----
    home      = home;
    configDir = "${home}/.config";
    cacheDir  = "${home}/.cache";
    dataDir   = "${home}/.local/share";

    # ---- Dotfiles ----
    dotfiles = "${home}/dotfiles";

    # ---- Containers + backups ----
    containers = "${home}/containers";
    backups    = "${home}/backups";

    # ---- Applications root (Linux-style) ----
    applicationsRoot = "${home}/Applications";
  };
}
