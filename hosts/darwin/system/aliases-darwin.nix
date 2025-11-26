# /Users/ven/dotfiles/nix/hosts/darwin/system/aliases-darwin.nix
#
# DARWIN: PATH ALIASES
# ------------------------------------------------------------
# Core path aliases for macOS:
#   - Home, Library, dotfiles, iCloud
#   - Applications (system + programming)
#   - Docker Desktop directories
#   - LaunchAgents, temp, caches, prefs
#
# Exposed under _module.args.aliasesDarwin.
# Shared alias module merges these with Linux equivalents.
# ------------------------------------------------------------

{ ... }:

let
  home    = "/Users/ven";
  library = "${home}/Library";

  applicationsRoot        = "/Applications";
  applicationsProgramming = "${applicationsRoot}/Programming";

  dotfiles = "${home}/dotfiles";
  iCloud   = "${home}/iCloudDocs";

  dockerApp        = "${applicationsProgramming}/Docker.app";
  dockerResources  = "${dockerApp}/Contents/Resources";
  dockerBin        = "${dockerResources}/bin";
  dockerPluginsDir = "${dockerResources}/cli-plugins";
in
{
  _module.args.aliasesDarwin = {

    # ---- Base directories ----
    home    = home;
    library = library;

    appSupport = "${library}/Application Support";
    prefs      = "${library}/Preferences";
    fontDir    = "${library}/Fonts";
    caches     = "${library}/Caches";
    logs       = "${library}/Logs";

    # ---- Homebrew ----
    brewPrefix = "/opt/homebrew";

    # ---- Temporary ----
    temp = "/tmp";

    # ---- Dotfiles + iCloud ----
    dotfiles = dotfiles;
    iCloud   = iCloud;

    scripts    = "${dotfiles}/nix/scripts";
    ssl        = "${dotfiles}/ssl";
    containers = "${dotfiles}/containers";

    # ---- Launch agents ----
    launchAgentsUser   = "${library}/LaunchAgents";
    launchAgentsGlobal = "/Library/LaunchAgents";

    # ---- Applications ----
    applicationsRoot        = applicationsRoot;
    applicationsProgramming = applicationsProgramming;

    # ---- Docker Desktop ----
    dockerApp        = dockerApp;
    dockerResources  = dockerResources;
    dockerBin        = dockerBin;
    dockerPluginsDir = dockerPluginsDir;
    dockerBinary     = "${dockerBin}/docker";
    dockerCompose    = "${dockerPluginsDir}/docker-compose";
  };
}
