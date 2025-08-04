I'll install home-manager as standalone since it has some benefits like separating the builds of system/user and not poluting boot entries


In this case you don't need: `home-manager.nixosModules.home-manager.enable = true` anywhere because THEN it would be as module.


Update home-manager configs:

home-manager --flake .#your-username@your-hostname switch

Update System configs:

sudo nixos-rebuild switch

# TODO

add blink instead of cmp maybe
