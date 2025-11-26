# /Users/ven/dotfiles/nix/hosts/linux/system/aliases-linux.nix
#
# LINUX: PATH ALIASES
# ------------------------------------------------------------
# Core path aliases for NixOS / Linux:
#   - Home, XDG directories
#   - Dotfiles, containers, backups
#   - User-level Applications root
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

    # ---- Core directories ----
    home      = home;
    configDir = "${home}/.config";
    cacheDir  = "${home}/.cache";
    dataDir   = "${home}/.local/share";

    # ---- Dotfiles ----
    dotfiles = "${home}/dotfiles";

    # ---- Containers / backups (future-safe) ----
    containers = "${home}/containers";
    backups    = "${home}/backups";

    # ---- Applications root (Linux variant) ----
    applicationsRoot = "${home}/Applications";
  };
}
