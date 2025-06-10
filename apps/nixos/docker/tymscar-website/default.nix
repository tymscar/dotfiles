{ pkgs, config, ... }:
let
  docker-env = config.age.secrets.docker-tymscar-website.path;
in
{
  systemd.services.tymscar-website = {
    description = "Tymscar.com";
    after = [
      "network.target"
      "docker.service"
    ];
    wants = [ "docker.service" ];
    serviceConfig = {
      ExecStart = "${pkgs.docker}/bin/docker compose --env-file ${docker-env} -f docker-compose.yaml up --force-recreate";
      ExecStop = "${pkgs.docker}/bin/docker compose -f docker-compose.yaml down";
      WorkingDirectory = "/home/tymscar/dotfiles/apps/nixos/docker/tymscar-website";
      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
