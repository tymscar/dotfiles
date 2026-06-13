{ pkgs, ... }:
{
  systemd.services.microbin = {
    description = "Microbin";
    after = [
      "network.target"
      "docker.service"
      "docker-create-proxy-network.service"
      "mnt-nas.mount"
    ];
    requires = [ "mnt-nas.mount" ];
    wants = [
      "docker.service"
      "docker-create-proxy-network.service"
    ];
    serviceConfig = {
      ExecStart = "${pkgs.docker}/bin/docker compose -f docker-compose.yml up --force-recreate";
      ExecStop = "${pkgs.docker}/bin/docker compose -f docker-compose.yml down";
      WorkingDirectory = "/home/tymscar/dotfiles/apps/nixos/docker/microbin";
      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
