# /Users/ven/dotfiles/nix/hosts/linux/paths-linux.nix

{ config, ... }:

let
  home = "/home/ven";   # DO NOT read from config.home
in {
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
