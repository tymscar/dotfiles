{ pkgs, ... }:
{
  systemd.services.dashy = {
    description = "Dashy";
    after = [
      "network.target"
      "docker.service"
      "docker-create-proxy-network.service"
    ];
    wants = [
      "docker.service"
      "docker-create-proxy-network.service"
    ];
    serviceConfig = {
      ExecStart = "${pkgs.docker}/bin/docker compose -f docker-compose.yml up --force-recreate";
      ExecStop = "${pkgs.docker}/bin/docker compose -f docker-compose.yml down";
      WorkingDirectory = "/home/tymscar/dotfiles/apps/nixos/docker/dashy";
      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
