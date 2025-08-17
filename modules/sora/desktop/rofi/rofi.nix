{pkgs, ...}: {
  programs.rofi = {
    enable = true;
  };

  xdg.configFile."rofi" = {
    source = ./rasi-files;
    recursive = true;
  };
}
