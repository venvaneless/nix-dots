# shared/home-shared.nix
{ pathsShared, ... }:

{
  home.username      = "ven";
  home.homeDirectory = pathsShared.home;
  home.stateVersion  = "25.11";

  programs.git.enable = true;
  programs.ssh.enable = true;
}
