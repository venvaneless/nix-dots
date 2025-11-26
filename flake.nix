# /Users/ven/dotfiles/nix/flake.nix
#
# FLAKE ROOT
# Main entry for all Nix configurations.
# Provides:
#   - Darwin with integrated Home Manager.
#   - NixOS with integrated Home Manager.
#   - Standalone Home Manager for Darwin and Linux.
#   - Shared path aliases and HM configuration.
# ============================================================

{
  description = "Ven’s setup";

  nixConfig.allow-dirty = true;

  # ============================================================
  # INPUTS
  # ============================================================
  inputs = {
    nixpkgs.url       = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin.url        = "github:LnL7/nix-darwin";
    home-manager.url  = "github:nix-community/home-manager";
    nix-homebrew.url  = "github:zhaofengli/nix-homebrew";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  # ============================================================
  # OUTPUTS
  # ============================================================
  outputs = inputs@{ self, nixpkgs, darwin, home-manager, nix-homebrew, ... }:
  let
    pkgsDarwin = import nixpkgs { system = "aarch64-darwin"; };
    pkgsLinux  = import nixpkgs { system = "x86_64-linux"; };
  in
  {

    # ------------------------------------------------------------
    # DARWIN: INTEGRATED HOME MANAGER
    # System-level config with Home Manager embedded.
    # ------------------------------------------------------------
    darwinConfigurations.macbook = darwin.lib.darwinSystem {
      system = "aarch64-darwin";

      specialArgs = {
        inherit inputs home-manager;
      };

      modules = [

        # ---- Home Manager Engine ----
        # Makes HM options available inside nix-darwin.
        inputs.home-manager.darwinModules.home-manager

        # ---- Aliases ----
        # Darwin- and shared-level path aliases.
        ./hosts/darwin/system/aliases-darwin.nix
        ./shared/aliases-shared.nix

        # ---- Paths ----
        # System PATH wiring for Darwin.
        ./hosts/darwin/system/paths-darwin.nix

        # ---- System Modules ----
        # macOS UI, fonts and system-level packages.
        ./hosts/darwin/host-darwin.nix

        # ---- Homebrew ----
        # Declarative brew and casks.
        ./hosts/darwin/system/homebrew.nix

        # ---- Inline system + HM core ----
        { lib, aliasesShared, inputs, pkgs, ... }:
        let
          nh = inputs.nix-homebrew or {};
        in
        {
          # ------------------------------------------------------
          # DARWIN: USER + SYSTEM ENVIRONMENT
          # ------------------------------------------------------

          # ---- Darwin: Primary User ----
          # macOS user must already exist on the system.
          system.primaryUser = "ven";

          # ---- Darwin: Home directory ----
          # System-level home directory for the primary user.
          users.users.ven.home = aliasesShared.home;

          # ---- System state version ----
          # Required by nix-darwin.
          # Pinning the Darwin release version.
          system.stateVersion = lib.mkForce 6;

          # ------------------------------------------------------
          # DARWIN: NIX CORE SETTINGS
          # ------------------------------------------------------

          # ---- Nix GC ----
          # Runs nix-store --optimise periodically.
          nix.optimise.automatic = true;

          # ---- Nix settings ----
          # Global flake + nix-command + binary caches.
          nix.settings = {
            # Global nix-command + flakes.
            experimental-features = [ "nix-command" "flakes" ];

             # ---Substituters and cache
            substituters = [
              "https://cache.nixos.org"
              "https://nix-community.cachix.org"
            ];

            # --Signing keys.
            trusted-public-keys = [ "nix-community.cachix.org-1:…" ];

            # --System build users.
            build-users-group = "nixbld";
          };

          # ------------------------------------------------------
          # DARWIN: SYSTEM ENVIRONMENT
          # ------------------------------------------------------

          # ---- Shell ----
          # Sets zsh as the system shell.
          programs.zsh.enable = true;

          # ---- Hostname ----
          # Used for networking and scutil.
          networking.hostName = "Vens-Macbook";

          # ---- Global PATH addition ----
          # Injects the nix binary path into system environment paths.
          # Darwin-only, uses the nix package derivation.
          environment.systemPath = [
            pkgs.nix
          ];

          # ------------------------------------------------------
          # DARWIN: NIX-HOMEBREW
          # ------------------------------------------------------
          imports = [ nh.darwinModules.nix-homebrew ];

          # ---- Nix-Homebrew: Core Settings ----
          # System-level Homebrew management via nix-homebrew.
          nix-homebrew = {
            enable        = true;
            user          = "ven";
            enableRosetta = false;
            autoMigrate   = true;

            # ---- Homebrew: Variables ----
            # --Updating
            global.autoUpdate     = true;
            # --Activation
            onActivation.cleanup  = "uninstall";
          };

          # ------------------------------------------------------
          # DARWIN: INTEGRATED HOME MANAGER
          # Darwin configuration with embedded Home Manager
          # ------------------------------------------------------

          # ---- Darwin: HM - Core Settings ----
          # Use system pkgs and per-user packages.
          home-manager.useGlobalPkgs   = true;
          home-manager.useUserPackages = true;

         # ---- Darwin: HM - User Environment ----
          # HM identity and base config
          home-manager.users.ven = {
            home.username      = "ven";
            home.homeDirectory = aliasesShared.home;
            home.stateVersion  = "25.11";

             # ---Git CLI
            Enables Git CLI in HM
            programs.git.enable = true;

            # ---SSH
            # Enables SSH in HM
            programs.ssh.enable = true;

             # ---- Extra HM modules ----
            imports = [
              ./shared/shared-home.nix
            ];
          };
        }
      ];
    };

    # ------------------------------------------------------------
    # LINUX: INTEGRATED HOME MANAGER
    # NixOS configuration with embedded Home Manager
    # ------------------------------------------------------------
    nixosConfigurations.linux = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inherit inputs home-manager;
      };

       # ---- Integrated HM: Modules ----
      modules = [
        # ---- Shared Aliases ----
        # Reuses aliasesShared when Linux aliases exist.
        ./shared/aliases-shared.nix

        # ---- Linux HM Engine ----
        home-manager.nixosModules.home-manager

        # ---- Linux: HM - Core Settings ----
        { aliasesShared, ... }: {
        	# Use system pkgs and per-user packages.
          home-manager.useGlobalPkgs   = true;
          home-manager.useUserPackages = true;

          # ---- Linux: HM - User Environment ----
          # HM identity and base config
          home-manager.users.ven = {
            home.username      = "ven";
            home.homeDirectory = aliasesShared.home;
            home.stateVersion  = "25.11";
            
            # ---Git CLI
            Enables Git CLI in HM
            programs.git.enable = true;

            # ---SSH
            # Enables SSH in HM
            programs.ssh.enable = true;

            imports = [
              ./shared/shared-home.nix
            ];
          };
        }
      ];
    };

    # ------------------------------------------------------------
    # SHARED: STANDALONE HOME MANAGER
    # HM-only configs for Darwin and Linux.
    # ------------------------------------------------------------
    homeConfigurations = {

      # ---- Darwin: Standalone HM ----
      ven-darwin = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsDarwin;

        extraSpecialArgs = {
          inherit inputs home-manager;
        };

        # ---- Darwin: Standalone HM - Modules ----
        modules = [
          ./hosts/darwin/system/aliases-darwin.nix
          ./shared/aliases-shared.nix

          # ---- Darwin: Core HM User ----
          { aliasesShared, pkgs, lib, ... }: {
            home.username      = "ven";
            home.homeDirectory = aliasesShared.home;
            home.stateVersion  = "25.11";
            
             # ---Git CLI
            Enables Git CLI in HM
            programs.git.enable = true;

            # ---SSH
            # Enables SSH in HM
            programs.ssh.enable = true;

            # Darwin-only PATH injection for HM session.
            home.sessionPath = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin [
              "${pkgs.nix}/bin"
            ];
          }

          ./shared/shared-home.nix
        ];
      };

      # ---- Linux: Standalone HM ----
      ven-linux = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsLinux;

        extraSpecialArgs = {
          inherit inputs home-manager;
        };

        # ---- Linux: Standalone HM - Modules ----
        modules = [
          ./shared/aliases-shared.nix

          # ---- Linux: Core HM User ----
          { aliasesShared, pkgs, lib, ... }: {
            home.username      = "ven";
            home.homeDirectory = aliasesShared.home;
            home.stateVersion  = "25.11";

            # ---Git CLI
            Enables Git CLI in HM
            programs.git.enable = true;

            # ---SSH
            # Enables SSH in HM
            programs.ssh.enable = true;

            # Darwin-only PATH injection (no-op on Linux).
            home.sessionPath = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin [
              "${pkgs.nix}/bin"
            ];
          }
          	# ---- Linux: Standalone HM - Modules ----
          ./shared/shared-home.nix
        ];
      };
    };
  };
}
