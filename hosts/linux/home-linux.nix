# /Users/ven/dotfiles/nix/hosts/linux/home-linux.nix

{ config, pkgs, lib, inputs, ... }:

# --- SET MACHINE: LINUX ----
lib.mkIf pkgs.stdenv.hostPlatform.isLinux {

  # --- LINUX HOME-MANAGER ----
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs   = true;
    useUserPackages = true;
    
    # ---- pass sharedPaths to HM ----
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
