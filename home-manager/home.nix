# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.flake-programs-sqlite.nixosModules.programs-sqlite

    # You can also split up your configuration and import pieces of it here:
    ../modules/desktop
    ../modules/programs/cli
  ];

  nixpkgs = {
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # Overlays
  nixpkgs.overlays = [ inputs.nvim-config.overlays.default ];

  home = {
    username = "akame";
    homeDirectory = "/home/akame";
  };

  home.packages = with pkgs; [
    # Fonts
    gohufont
    nerd-fonts.gohufont

    # CLI
    alacritty # terminal emulator
    fish # shell
    wl-clipboard # wayland clipboard
    pavucontrol # mixer
    btop # process monitor
    fzf # it's used to find something
    ripgrep # also used to find things
    nvim-pkg

    # browser
    brave

    # Screenshoot
    swappy
    grim
    slurp
    ];

  # Enable home-manager and git
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
