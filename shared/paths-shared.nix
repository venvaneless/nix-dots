# shared/paths-shared.nix
{ pathsDarwin ? {}, pathsLinux ? {}, ... }:

{
  _module.args.pathsShared =
    pathsDarwin // pathsLinux // {
      # extra portable dirs
      configDir = "${pathsDarwin.home or pathsLinux.home}/.config";
      cacheDir  = "${pathsDarwin.home or pathsLinux.home}/.cache";
      dataDir   = "${pathsDarwin.home or pathsLinux.home}/.local/share";
    };
}
