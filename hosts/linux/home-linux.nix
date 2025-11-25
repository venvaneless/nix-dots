# /Users/ven/dotfiles/nix/hosts/linux/home-linux.nix

{ config, pkgs, lib, inputs, ... }:

{
	# --- LINUX HOME-MANAGER ----
  imports = [
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

      # linux-only HM things later…
    };
  };
}
