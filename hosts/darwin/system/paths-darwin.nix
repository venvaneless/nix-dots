# /Users/ven/dotfiles/nix/hosts/darwin/system/paths-darwin.nix

{ ... }:

let
  home    = "/Users/ven";
  library = "${home}/Library";

  applicationsRoot       = "/Applications";
  applicationsProgramming = "${applicationsRoot}/Programming";

  dotfiles = "${home}/dotfiles";
  iCloud   = "${home}/iCloudDocs";

  dockerApp        = "${applicationsProgramming}/Docker.app";
  dockerResources  = "${dockerApp}/Contents/Resources";
  dockerBin        = "${dockerResources}/bin";
  dockerPluginsDir = "${dockerResources}/cli-plugins";

in
{
  _module.args.pathsDarwin = {

    home      = home;
    library   = library;
    appSupport = "${library}/Application Support";
    prefs      = "${library}/Preferences";
    fontDir    = "${library}/Fonts";
    caches     = "${library}/Caches";
    logs       = "${library}/Logs";

    brewPrefix = "/opt/homebrew";
    temp       = "/tmp";

    dotfiles   = dotfiles;
    iCloud     = iCloud;

    scripts    = "${dotfiles}/nix/scripts";
    ssl        = "${dotfiles}/ssl";
    containers = "${dotfiles}/containers";

    launchAgentsUser   = "${library}/LaunchAgents";
    launchAgentsGlobal = "/Library/LaunchAgents";

    applicationsRoot        = applicationsRoot;
    applicationsProgramming = applicationsProgramming;

    dockerApp        = dockerApp;
    dockerResources  = dockerResources;
    dockerBin        = dockerBin;
    dockerPluginsDir = dockerPluginsDir;
    dockerBinary     = "${dockerBin}/docker";
    dockerCompose    = "${dockerPluginsDir}/docker-compose";
  };
}
