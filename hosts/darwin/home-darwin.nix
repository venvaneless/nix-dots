# /Users/ven/dotfiles/nix/hosts/darwin/home-darwin.nix
#
# HOME MANAGER (DARWIN-INTEGRATED)
# ============================================================

{ config, lib, inputs, ... }:

{
  imports = [
    # --- DARWIN HOME-MANAGER ----
    inputs.home-manager.darwinModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs   = true;
    useUserPackages = true;

    # ---- pass sharedPaths to HM ----
    extraSpecialArgs = {
      inherit (config) sharedPaths;
    };

    users.ven = {
      # ---- SHARED HOME MANAGER ROOT MODULE ----
      imports = [
        ../../shared/home-shared.nix
      ];

      # ---- DARWIN HOME-MANAGER PATH ----
      home.sessionPath = [
        "${config.home.homeDirectory}/.local/bin"
      ];
    };
  };
}
