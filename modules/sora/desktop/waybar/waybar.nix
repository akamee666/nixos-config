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

 xdg.configFile."waybar" = {
    source = ./${theme}; # Assuming 'theme' is a directory with config, style.css etc.
    recursive = true;
  };

  xdg.configFile."waybar/scripts" = {
    source = ./scripts;
    recursive = true;
  };}
