{
  description = "My NixOS config :D";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Hyprland
    hyprland = {  
      url = "github:hyprwm/Hyprland"; 
      # Uncommenting it makes it fail to build.
      # inputs.nixpkgs.follows = "nixpkgs"; # Avoid version dismatch with MESA/OpenGL
    };

    # Yazi plugins
    nix-yazi-plugins = {
      url = "github:lordkekz/nix-yazi-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Command-not-found
    # NixOS systems configured with flakes and thus lacking channels usually have a broken command-not-found. The reason is that the backing database programs.sqlite is only available on channels. The problem is that the channel URL can not be determined from the nixpkgs revision alone, as it also contains a build number.
    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim-config = {
      url = "path:./modules/programs/cli/neovim";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = [
      "x86_64-linux"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    # nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    # homeManagerModules = import ./modules/home-manager;



    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          # > Our main nixos configuration file <
          ./hosts/nixos/configuration.nix
          # SystemWide imports
          inputs.flake-programs-sqlite.nixosModules.programs-sqlite
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager switch --flake .#your-username@your-hostname'
    homeConfigurations = {
      "akame@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          # > Our main home-manager configuration file <
          ./home-manager/home.nix
        ];
      };
    };
  };
}
