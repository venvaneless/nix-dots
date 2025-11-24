# hosts/darwin/host-darwin.nix
{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    # Paths for darwin
    ../../shared/path-overrides.nix
    ../../shared/paths-shared.nix
    ./paths-darwin.nix
    
    # System-level modules
    ./system/system.nix
    ./system/sys-paths.nix
    
    # Home-level modules
    ./home-darwin.nix
  ];
}
