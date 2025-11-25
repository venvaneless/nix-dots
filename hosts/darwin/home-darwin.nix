# /Users/ven/dotfiles/nix/hosts/darwin/home-darwin.nix
#
# HOME MANAGER (DARWIN-INTEGRATED)
# ============================================================

{ config, lib, inputs, ... }:

# --- SET MACHINE: macOS ----
lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
	
	# --- DARWIN HOME-MANAGER ----
  imports = [
    inputs.home-manager.darwinModules.home-manager
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
