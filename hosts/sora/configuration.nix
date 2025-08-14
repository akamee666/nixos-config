{ 
  config,
  pkgs, 
  inputs,
  lib,
  ...
}:

{
  imports = [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./system-packages.nix
      ./services.nix

      # Flakes
      inputs.lanzaboote.nixosModules.lanzaboote
      inputs.flake-programs-sqlite.nixosModules.programs-sqlite
  ];

  nixpkgs.config.allowUnfree = true;


  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 21d";
    };

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;

      # Cachix, avoid building binaries not available in nixcache.
      substituters = ["https://hyprland.cachix.org" "https://nix-community.cachix.org"];

      # All substituters should be trusted if you want to pull from them
      trusted-substituters = [
        "https://cache.nixos.org"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.nixos.label = "NixOS_${builtins.substring 6 8 config.system.nixos.version}";

  # TODO: Change it later
  programs.git.enable = true;
  programs.command-not-found.enable = true;
  programs.fish.enable = true;

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  networking.hostName = "sora";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  console.keyMap = "br-abnt2";

  users.users.ak4m3 = {
    isNormalUser = true;
    home = "/home/ak4m3";
    description = " ak4m3";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };

  environment.variables.EDITOR = "nvim";
  services.getty.autologinUser = "ak4m3";
  system.stateVersion = "25.05"; # Did you read the comment?
}
