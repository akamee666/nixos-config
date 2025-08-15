{...}: {

  programs.eww = {
    enable = true;
  };

  xdg.configFile."eww" = {
    source = ./config;
    recursive = true;
  };

}
