# /Users/ven/dotfiles/nix/hosts/linux/aliases.nix
#
# LINUX: PATH ALIASES
# Core path aliases for NixOS / Linux:
#   - Home, XDG directories
#   - Dotfiles, containers, backups
#   - Applications root and user bin
# ============================================================

{ ... }:

let
  home = "/home/ven";
in
{
  # ------------------------------------------------------------
  # LINUX ALIASES
  # Exported as aliasesLinux for future shared consumption.
  # ------------------------------------------------------------
  _module.args.aliasesLinux = {
    # ------ Base directories ------
    home      = home;
    configDir = "${home}/.config";
    cacheDir  = "${home}/.cache";
    dataDir   = "${home}/.local/share";

    # ------ Dotfiles and data ------
    dotfiles   = "${home}/dotfiles";
    containers = "${home}/containers";
    backups    = "${home}/backups";

    # ------ Applications and binaries ------
    applicationsRoot = "${home}/Applications";
    binUser          = "${home}/bin";
    localBin         = "${home}/.local/bin";
  };
}
