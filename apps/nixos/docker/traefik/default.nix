{ pkgs, config, ... }:
let
  docker-env = config.age.secrets.docker-traefik.path;
in
{
  systemd.tmpfiles.rules = [
    "d /var/lib/traefik 0700 root root -"
    "f /var/lib/traefik/acme.json 0600 root root -"
  ];

  systemd.services.traefik = {
    description = "Traefik";
    after = [
      "network.target"
      "docker.service"
    ];
    wants = [ "docker.service" ];
    serviceConfig = {
      ExecStart = "${pkgs.docker}/bin/docker compose --env-file ${docker-env} -f docker-compose.yml up --force-recreate";
      ExecStop = "${pkgs.docker}/bin/docker compose -f docker-compose.yml down";
      WorkingDirectory = "/home/tymscar/dotfiles/apps/nixos/docker/traefik";
      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
