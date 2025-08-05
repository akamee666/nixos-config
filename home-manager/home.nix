# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ../modules/desktop
    ../modules/programs/cli
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # Overlays
  nixpkgs.overlays = [
    inputs.nvim-config.overlays.default
    inputs.alacritty-theme.overlays.default
  ];

  home = {
    username = "akame";
    homeDirectory = "/home/akame";
  };

  home.packages = with pkgs; [
    # Fonts
    gohufont
    nerd-fonts.gohufont
    nerd-fonts.ubuntu-sans
    hachimarupop

    # CLI
    alacritty # terminal emulator
    fish # shell
    wl-clipboard # wayland clipboard
    btop # process monitor
    fzf # fuzzy finder to find things
    ripgrep # finder to search for things
    nvim-pkg # my neovim cfg overlay
    bat # Replacing cat
    alejandra # nixformatter
    killall # utils (this shouldn't be here)
    # ueberzugpp # Show images in terminal

    # Utils
    brave # browser
    pavucontrol # mixer
    playerctl
    spotify # Music yay
    rofi # menu

    # Screenshoot
    swappy
    grim
    slurp

    # Desktop
    hyprpaper # wallpaper
    hyprpicker # color picker
    waybar # customizable wayland bar
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default # cursor
  ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.05";
}
