### macOS
let
  system = "aarch64-darwin";
in {
  darwinConfigurations.macbook = darwin.lib.darwinSystem {
    inherit system;
    # ...
  };
}


## Linux
let
  system = "x86_64-linux";
in {
  nixosConfigurations.linux = nixpkgs.lib.nixosSystem {
    inherit system;
    # ...
  };
}


## Unofrm
let
  system = "aarch64-darwin";
  pkgs   = import nixpkgs { inherit system; };
in
{
  darwinConfigurations.macbook = darwin.lib.darwinSystem {
    inherit system;
    # ...
  };
}