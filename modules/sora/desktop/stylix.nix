{ pkgs, inputs, ... }: {
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  stylix = {
    enable = true;
    image = ../../../wallpapers/red.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    targets.alacritty.enable = false;
    targets.fish.enable = false;
  };
}
