{ pkgs, config, ... }:

let
  dockerEnv = config.age.secrets.docker-n8n.path;
in
{
  systemd.services.n8n = {
    description = "n8n workflow automation";
    after = [
      "network.target"
      "docker.service"
    ];
    wants = [ "docker.service" ];

    serviceConfig = {
      ExecStart = "${pkgs.docker}/bin/docker compose --env-file ${dockerEnv} -f docker-compose.yml up --force-recreate";
      ExecStop = "${pkgs.docker}/bin/docker compose -f docker-compose.yml down";
      WorkingDirectory = "/home/tymscar/dotfiles/apps/nixos/docker/n8n";
      Restart = "always";
    };

    wantedBy = [ "multi-user.target" ];
  };
}
