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
    # Linux-specific system modules (optional future)
    ./system/system-linux.nix

    # Standalone Home Manager config
    ./home/linux-home.nix

    # Cross-platform + linux-specific paths
    ../../shared/path-overrides.nix
  ];
}
