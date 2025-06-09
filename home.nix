{ lib, ... }:
{
  home-manager = {
    users.shakhzod = {
      programs = {
        topgrade = {
          enable = true;
          settings = {
            linux = lib.mkForce {
              nix_arguments = "--flake github:shakhzodkudratov/hetzner-nixos --option tarball-ttl 0";
            };
          };
        };
      };

      home = {
        stateVersion = "25.05";
      };
    };
  };
}
