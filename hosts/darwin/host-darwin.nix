# /Users/ven/dotfiles/nix/hosts/darwin/host-darwin.nix
{ config, pkgs, lib, inputs, ... }:

{
  # --- SYSTEM USER (Darwin) ---
  # nix-darwin system-level user (macOS user must already exist)
  system.primaryUser  = "ven";
  system.stateVersion = lib.mkForce 6;

  # --- INTEGRATED HOME MANAGER (Darwin) ---
  # Load the Home Manager module into nix-darwin
  imports = [
    inputs.home-manager.darwinModules.home-manager

    # (you can add system modules later)
    # ./system/system.nix
    # ./system/homebrew.nix
    # ./system/sys-paths.nix
  ];

  # HM settings for integrated mode
  home-manager.useGlobalPkgs   = true;
  home-manager.useUserPackages = true;

  # Attach the HM user config here
  home-manager.users.ven = {
    imports = [
      # This is a Home Manager module, so it belongs HERE,
      # not in the top-level nix-darwin imports list.
      ../../shared/home-shared.nix
    ];
  };
}
