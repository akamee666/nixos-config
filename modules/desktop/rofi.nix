{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    font = "GohuFont 14 Nerd Font Mono";
    theme = "${pkgs.rofi}/share/rofi/themes/gruvbox-dark-hard.rasi";
  };
}
