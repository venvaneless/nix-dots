# /Users/ven/dotfiles/nix/shared/paths-shared.nix
#
# SHARED: Cross-platform user paths
# ================================================
# These paths are not tied to macOS or Linux.
# They only point to directories inside your HOME.
# ================================================

{ config, ... }:

let
  home = config.sharedPaths.home
  dotfiles = "${home}/dotfiles";
  
in
{
	config.pathsShared = {

    # --- Base folders ---
    home         = home;
    dotfiles     = dotfiles;

    # --- Dotfiles subfolders ---
    zsh          = "${dotfiles}/zsh";
    ssl          = "${dotfiles}/ssl";
    scripts      = "${dotfiles}/nix/scripts";
    containers   = "${dotfiles}/containers";

    # --- Generic XDG-like dirs (portable) ---
    local-data   = "${home}/.local/share";
    config       = "${home}/.config";
    cache        = "${home}/.cache";
  };
}
