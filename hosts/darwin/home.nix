# /Users/ven/dotfiles/nix/hosts/darwin/home.nix

{ pkgs, lib, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.ven = {
    home.username = "ven";
    home.homeDirectory = "/Users/ven";
    home.stateVersion = "25.11";

    imports = [
      # ../shell/zsh.nix
      # ../services/user-data-symlinking.nix
    ];
  };
}
