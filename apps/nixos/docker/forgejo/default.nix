{ pkgs, config, ... }:

let
  docker-env = config.age.secrets.docker-forgejo.path;
in
{
  systemd.services.forgejo = {
    description = "Forgejo git server";
    after = [
      "network.target"
      "docker.service"
      "mnt-nas.mount"
    ];
    requires = [ "mnt-nas.mount" ];
    wants = [ "docker.service" ];

    serviceConfig = {
      ExecStart = "${pkgs.docker}/bin/docker compose --env-file ${docker-env} -f docker-compose.yml up --force-recreate";
      ExecStop = "${pkgs.docker}/bin/docker compose -f docker-compose.yml down";
      WorkingDirectory = "/home/tymscar/dotfiles/apps/nixos/docker/forgejo";
      Restart = "always";
    };

    wantedBy = [ "multi-user.target" ];
  };
}
