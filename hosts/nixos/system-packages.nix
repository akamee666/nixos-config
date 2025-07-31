{inputs, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    neovim
    yazi
    kitty
    tree
    eza
    fd
    libinput
  ];

  # This will be pulled by nixpkgs
  # programs.hyprland.enable = true;

  # This will be pulled by the inputs variable set in flake.nix and imported bc of specialArgs = {inherint inputs };
  programs.hyprland = {
   enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
   portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
}
