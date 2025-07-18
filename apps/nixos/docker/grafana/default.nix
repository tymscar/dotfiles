{ pkgs, config, ... }:

let
  dockerEnv = config.age.secrets.docker-grafana.path;
in
{
  systemd.services.grafana = {
    description = "Grafana";
    after       = [ "network.target" "docker.service" ];
    wants       = [ "docker.service" ];

    serviceConfig = {
      ExecStart  = "${pkgs.docker}/bin/docker compose --env-file ${dockerEnv} -f docker-compose.yml up --force-recreate";
      ExecStop   = "${pkgs.docker}/bin/docker compose -f docker-compose.yml down";
      WorkingDirectory = "/home/tymscar/dotfiles/apps/nixos/docker/grafana";
      Restart    = "always";
    };

    wantedBy = [ "multi-user.target" ];
  };
}
