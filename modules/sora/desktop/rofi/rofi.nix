{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    font = "GohuFont 14 Nerd Font Mono";
  };

  xdg.configFile."rofi" = {
    source = ./rasi-files;
    recursive = true;
  };
}
