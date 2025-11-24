{ config, ... }:

let
  home = config.home.homeDirectory;
in
{
  pathsLinux = {
    config				= "${home}/.config";
    data					= "${home}/.local/share";
    cache					= "${home}/.cache";
    runtime				= "${home}/.local/run";
    temp					= "${home}/.local/tmp";
    bin						= "${home}/.local/bin";
  };
}
