# /Users/ven/dotfiles/nix/hosts/linux/home-linux.nix

{ config, pkgs, lib, inputs, ... }:

# --- SET MACHINE: LINUX ----
lib.mkIf pkgs.stdenv.hostPlatform.isLinux {

  imports = [
  # --- LINUX HOME-MANAGER ----
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
  # ---- pass sharedPaths to HM ----
    useGlobalPkgs   = true;
    useUserPackages = true;

    extraSpecialArgs = {
      sharedPaths = config.sharedPaths;
    };

    users.ven = {
      imports = [
      	# ---- SHARED HOME MANAGER ROOT MODULE ----
        ../../shared/home-shared.nix
      ];
    };
  };
}
