{ pkgs, config, ... }:
let
  docker-env = config.age.secrets.docker-tymscar-resume.path;
in
{
  systemd.services.tymscar-resume = {
    description = "Tymscar's resume";
    after = [
      "network.target"
      "docker.service"
      "mnt-nas.mount"
    ];
    requires = [ "mnt-nas.mount" ];
    wants = [ "docker.service" ];
    serviceConfig = {
      ExecStart = "${pkgs.docker}/bin/docker compose --env-file ${docker-env} -f docker-compose.yaml up --force-recreate";
      ExecStop = "${pkgs.docker}/bin/docker compose -f docker-compose.yaml down";
      WorkingDirectory = "/home/tymscar/dotfiles/apps/nixos/docker/resume";
      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
