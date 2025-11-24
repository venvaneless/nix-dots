# hosts/darwin/host-darwin.nix
{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    # System-level modules
    ./system/system.nix
    ./system/sys-paths.nix

    # Home Manager for Darwin
    ./home-darwin.nix

    # Path overrides (shared + macOS-specific)
    ../../shared/path-overrides.nix
  ];
}
