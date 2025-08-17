{ pkgs, inputs, ... }: {

  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  programs.stylix = {
    enable = true;

    image = ../../../wallpapers/red.png;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    # Font settings
    fonts = {
      monospace = "Gohu Font 14 Nerd Font Mono";
    };
  };
}
