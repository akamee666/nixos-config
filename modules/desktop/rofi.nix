{...}: {
  programs.rofi = {
    enable = true;
    extraConfig = {
      theme = "gruvbox-hard";
      font = "GohuFont 14 Nerd Font Mono";
      show-icons = true;
    };
  };
}
