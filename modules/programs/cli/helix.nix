{
  pkgs,
  ...
}:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "autumn_night";
      languages.language = [

        # Nix
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
        }
      ];
    };
  };
}

