{ pkgs, ... }:
{
  systemd.services.audiobookshelf = {
    description = "Audio Bookshelf";
    after = [
      "network.target"
      "docker.service"
      "mnt-nas.mount"
    ];
    requires = [ "mnt-nas.mount" ];
    wants = [ "docker.service" ];
    serviceConfig = {
      ExecStart = "${pkgs.docker}/bin/docker compose -f docker-compose.yml up --force-recreate";
      ExecStop = "${pkgs.docker}/bin/docker compose -f docker-compose.yml down";
      WorkingDirectory = "/home/tymscar/dotfiles/apps/nixos/docker/audiobookshelf";
      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
