{ pkgs, inputs, ... }: {
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  stylix = {
    enable = true;
    base16Scheme = ../../../themes/blue.yaml;

    targets.alacritty.enable = false;
    targets.fish.enable = false;
  };
}
