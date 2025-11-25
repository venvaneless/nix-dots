# /Users/ven/dotfiles/nix/shared/paths-shared.nix
#
# SHARED: Cross-platform user paths
# ================================================
# These paths derive from the host-level HOME path
# defined in:
#   - hosts/darwin/paths-darwin.nix
#   - hosts/linux/paths-linux.nix
#
# No dependency on Home Manager here.
# ================================================

{ config, lib, ... }:

let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  isLinux  = pkgs.stdenv.hostPlatform.isLinux;

  hostHome =
    if isDarwin then config.pathsDarwin.home
    else if isLinux then config.pathsLinux.home
    else null;

  dotfiles =
    if hostHome != null then "${hostHome}/dotfiles" else null;

in
{
	config.pathsShared = lib.mkIf (hostHome != null) {
		
    # --- Base folders ---
    home     = hostHome;
    dotfiles = dotfiles;

    # --- Dotfiles subfolders ---
    zsh        = "${dotfiles}/zsh";
    ssl        = "${dotfiles}/ssl";
    scripts    = "${dotfiles}/nix/scripts";
    containers = "${dotfiles}/containers";

    # --- Generic XDG-like dirs (portable) ---
    local-data = "${hostHome}/.local/share";
    config     = "${hostHome}/.config";
    cache      = "${hostHome}/.cache";
  };
}
