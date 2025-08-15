{pkgs, ...}: let
  # minimal-brown, gruvbox, binary-theme
  theme = "binary";
  pythonWithMyLibs = pkgs.python3.withPackages (ps:
    with ps; [
      pyquery
    ]);
in {
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./${theme}/style.css;
  };

  # Weather
  xdg.configFile."waybar/scripts".source = ./scripts;
  xdg.configFile."waybar".source = ./${theme};
}
