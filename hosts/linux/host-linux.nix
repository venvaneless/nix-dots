# /Users/ven/dotfiles/nix/hosts/linux/host-linux.nix
#
# HOST (LINUX SYSTEM ENTRYPOINT)
# ============================================================
# Loads Linux system modules (if you later create them),
# and loads the standalone Home Manager entrypoint.
# ============================================================

{ config, pkgs, lib, inputs, ... }:

{
  imports = [
  	# Paths for Linux
  	../../shared/path-overrides.nix
   ../../shared/path-overrides.nix
   
   # Home-level modules for Linux
    ./home/home-liux.nix


    
  ];
}
