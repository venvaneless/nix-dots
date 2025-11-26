# /Users/ven/dotfiles/nix/hosts/darwin/services/brew-pkgs.nix
#
# DARWIN: HOMEBREW PACKAGES
# Declarative Homebrew configuration for macOS:
#   - Global behavior and activation flags
#   - Taps, brews and casks
#   - Uses hardcoded appdir for now (no aliases wiring yet)
# ============================================================

{ ... }:

{
  # ------------------------------------------------------------
  # HOMEBREW CORE
  # Enable declarative Homebrew management.
  # ------------------------------------------------------------
  homebrew = {
    enable = true;

    # ------ Global settings ------
    global = {
      autoUpdate = true;
    };

    # ------ Activation behavior ------
    onActivation = {
      autoUpdate = true;
      upgrade    = false;
      cleanup    = "none";
    };

    # ------ Taps ------
    taps = [
      # --- Core taps (uncomment as needed) ---
      # "homebrew/cask"
      # "homebrew/core"
    ];

    # ------ Brews ------
    brews = [
      "nginx"
      "mkcert"
    ];

    # ------ Casks ------
    casks = [
      {
        name = "ungoogled-chromium";
        # Hardcoded appdir for now, no aliasesShared wiring.
        args = { appdir = "/Applications"; };
      }
    ];
  };
}
