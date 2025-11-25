# /Users/ven/dotfiles/nix/hosts/linux/paths-linux.nix
#
# LINUX: System-level paths
# ============================================================

{ config, ... }:

let
  # System-level home path for "ven" on Linux
  home = "/home/ven";
in
{
  config.pathsLinux = {
    home    = home;
    config  = "${home}/.config";
    data    = "${home}/.local/share";
    cache   = "${home}/.cache";
    runtime = "${home}/.local/run";
    temp    = "${home}/.local/tmp";
    bin     = "${home}/.local/bin";
  };
}
