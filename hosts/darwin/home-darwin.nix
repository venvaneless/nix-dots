# /Users/ven/dotfiles/nix/hosts/darwin/home-darwin.nix

{ config, lib, inputs, ... }:

{
  imports = [
    # --- DARWIN HOME-MANAGER ----
    inputs.home-manager.darwinModules.home-manager
  ];
 
  home-manager = {
    # - System pkgs
    # - HM user package
    useGlobalPkgs   = true;
    useUserPackages = true;

    # ---- pass sharedPaths to HM (was missing!) ----
    extraSpecialArgs = {
      sharedPaths = config.sharedPaths;
    };

    # --- DARWIN HOME-MANAGER MODULES HERE ----
    users.ven = {
      imports = [
        ../../shared/home-shared.nix
      ];

      # --- DARWIN HOME-MANAGER PATH ----
      home.sessionPath = [
        "${config.home.homeDirectory}/.local/bin"
      ];
    };
  };
}
