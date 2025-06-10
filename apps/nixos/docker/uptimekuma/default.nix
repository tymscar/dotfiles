{ pkgs, ... }:
{
  systemd.services.uptime-kuma = {
    description = "Uptime Kuma";
    after = [ "network.target" "docker.service" ];
    wants = [ "docker.service" ];
    serviceConfig = {
      ExecStart = "${pkgs.docker}/bin/docker compose -f docker-compose.yml up --force-recreate";
      ExecStop = "${pkgs.docker}/bin/docker compose -f docker-compose.yml down";
      WorkingDirectory = "/home/tymscar/dotfiles/apps/nixos/docker/uptimekuma";
      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
