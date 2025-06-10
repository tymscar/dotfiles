{ pkgs, config, ... }:
let
  docker-env = config.age.secrets.docker-linkfix.path;
in
{
  systemd.services.linkfix = {
    description = "Discord Linkfix Bot";
    after = [
      "network.target"
      "docker.service"
    ];
    wants = [ "docker.service" ];
    serviceConfig = {
      ExecStart = "${pkgs.docker}/bin/docker compose --env-file ${docker-env} -f docker-compose.yml up --force-recreate";
      ExecStop = "${pkgs.docker}/bin/docker compose -f docker-compose.yml down";
      WorkingDirectory = "/home/tymscar/dotfiles/apps/nixos/docker/linkfix";
      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
