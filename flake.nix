{
  description = "Ven’s setup";

  nixConfig.allow-dirty = true;

  inputs = {
    nixpkgs.url       = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin.url        = "github:LnL7/nix-darwin";
    home-manager.url  = "github:nix-community/home-manager";
    nix-homebrew.url  = "github:zhaofengli/nix-homebrew";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, nix-homebrew, ... }:
  let
    pkgsDarwin = import nixpkgs { system = "aarch64-darwin"; };
    pkgsLinux  = import nixpkgs { system = "x86_64-linux"; };
  in
  {
    ##############################
    ## Integrated Darwin HM
    ##############################
    darwinConfigurations.macbook = darwin.lib.darwinSystem {
      system = "aarch64-darwin";

      specialArgs = { inherit inputs home-manager nix-homebrew; };

      modules = [
        # ./hosts/darwin/paths-darwin.nix
        # ./shared/path-overrides.nix

        # ./hosts/darwin/host-darwin.nix
      ];
    };

    ##############################
    ## Integrated Linux HM
    ##############################
    nixosConfigurations.linux = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = { inherit inputs home-manager; };

      modules = [
        #./hosts/linux/paths-linux.nix
        #./shared/path-overrides.nix

        #./hosts/linux/host-linux.nix
      ];
    };

    ##############################
    ## Standalone Darwin HM
    ##############################
    homeConfigurations.ven-darwin = home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsDarwin;
      modules = [ .# /hosts/darwin/home-darwin.nix ];
    };

    ##############################
    ## Standalone Linux HM
    ##############################
    homeConfigurations.ven-linux = home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsLinux;
      modules = [ # ./hosts/linux/home-linux.nix ];
    };
  };
}
