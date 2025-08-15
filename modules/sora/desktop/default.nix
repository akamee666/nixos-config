{...}: {
  imports = [
    ./hyprland.nix
    ./rofi.nix
    ./waybar/waybar.nix
    ./eww/eww.nix
  ];

  xdg.configFile."scripts" = {
    source = ./scripts;
    recursive = true; 
  };
}
