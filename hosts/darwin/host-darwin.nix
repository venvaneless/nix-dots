# hosts/darwin/host-darwin.nix
{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    # System-level modules
    ./system/system.nix
    ./system/homebrew.nix
    ./system/sys-paths.nix
  ];
}
