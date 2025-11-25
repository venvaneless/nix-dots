# /Users/ven/dotfiles/nix/hosts/darwin/paths-darwin.nix
#
# DARWIN: System-level macOS paths
# ============================================================

{ config, pkgs, ... }:

let
  # System-level home path for the "ven" user
  home				=		"/Users/ven";
  library			=		"${home}/Library";

  # Application roots
  appsRoot		=		"/Applications";
  appsProg		=		"${appsRoot}/Programming";
  appsProd		=		"${appsRoot}/Productivity";

  # Docker app root
  dockerApp					=		"${appsProg}/Docker.app";
  dockerResources		=		"${dockerApp}/Contents/Resources";
  dockerBin					=		"${dockerResources}/bin";
  dockerPluginsDir	=		"${dockerResources}/cli-plugins";

  # Dotfiles root
  dotfiles					=		"${home}/dotfiles";

  # iCloud (macOS only)
  iCloud						=		"${home}/iCloudDocs";

in
{
	config.pathsDarwin = {

    # ------------------------------------------------------------
    # CORE macOS DIRECTORIES
    # ------------------------------------------------------------
    home					=		home;
    library				=		library;
    appSupport		=		"${library}/Application Support";
    prefs					=		"${library}/Preferences";
    fonts					=		"${library}/Fonts";
    caches				=		"${library}/Caches";
    logs					=		"${library}/Logs";

    # ------------------------------------------------------------
    # SYSTEM DIRECTORIES
    # ------------------------------------------------------------
    brewPrefix			=		"/opt/homebrew";
    temp						=		"/tmp";

    dotfiles				=		dotfiles;
    iCloud					=		iCloud;

    # Dotfiles sub-dirs
    scripts					=		"${dotfiles}/nix/scripts";
    ssl							=		"${dotfiles}/ssl";
    containers			=		"${dotfiles}/containers";

    # ------------------------------------------------------------
    # LAUNCHD
    # ------------------------------------------------------------
    launchAgentsUser				=		"${library}/LaunchAgents";
    launchAgentsGlobal			=		"/Library/LaunchAgents";

    # ------------------------------------------------------------
    # APPLICATION ROOTS
    # ------------------------------------------------------------
    appsRoot						=		appsRoot;
    appsProgramming			=		appsProg;
    appsProductivity		=		appsProd;

    # ------------------------------------------------------------
    # DOCKER PATHS (fully expanded, no broken variables)
    # ------------------------------------------------------------
    dockerApp						=		dockerApp;
    dockerResources			=		dockerResources;

    dockerBin						=		dockerBin;
    dockerPluginsDir		=		dockerPluginsDir;

    dockerBinary				=		"${dockerBin}/docker";
    dockerCompose				=		"${dockerPluginsDir}/docker-compose";

    dockerCredDesktop		=		"${dockerBin}/docker-credential-desktop";
    dockerCredEcrLogin	=		"${dockerBin}/docker-credential-ecr-login";
    dockerCredOsxkey		=		"${dockerBin}/docker-credential-osxkeychain";

    dockerKubectl				=		"${dockerBin}/kubectl";
    dockerHubTool				=		"${dockerBin}/hub-tool";
    dockerCAgent				=		"${dockerBin}/cagent";

    # ------------------------------------------------------------
    # BACKUP DIRECTORIES
    # ------------------------------------------------------------
    bkpFolder						=		"${iCloud}/my-system";
    bkpAppData					=		"${iCloud}/my-system/01-app_data";
    bkpContainer				=		"${iCloud}/my-system/04-containers";
    bkpScripts					=		"${iCloud}/my-system/00-sys_assets/scripts";
  };
}
