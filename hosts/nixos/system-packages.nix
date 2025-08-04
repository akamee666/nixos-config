{inputs, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    yazi
    kitty
    tree
    eza
    fd
  ];

  # Fish config is manager responsible but shell is installed systemwide
  # programs.fish.enable = true;
  # Enable home-manager and git
  programs.git.enable = true;
  programs.command-not-found.enable = true;
  programs.fish.enable = true;

  # This would be pulled by nixpkgs
  # programs.hyprland.enable = true;
  # This below, instead, will be pulled by the inputs variable set in flake.nix and imported bc of specialArgs = {inherint inputs };
  programs.hyprland = {
   enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Enable the XWayland compatibility layer for X11 applications
  programs.xwayland.enable = true;
}
