# /Users/ven/dotfiles/nix/hosts/linux/home-linux.nix
#
# HOME MANAGER (LINUX)
# ============================================================

{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    # --- LINUX HOME-MANAGER ----
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
      # ---- SHARED HOME MANAGER ROOT MODULE ----
      imports = [
        ../../shared/home-shared.nix
      ];

      home.sessionPath = [
        "${config.home.homeDirectory}/.local/bin"
      ];
    };
  };
}
