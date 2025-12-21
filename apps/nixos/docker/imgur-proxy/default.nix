{ pkgs, config, ... }:
let
  docker-env = config.age.secrets.docker-imgur-proxy.path;
in
{
  systemd.services.imgur-proxy = {
    description = "Imgur Proxy with VPN";
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
      ExecStart = "${pkgs.docker}/bin/docker compose --env-file ${docker-env} -f docker-compose.yml up --force-recreate";
      ExecStop = "${pkgs.docker}/bin/docker compose -f docker-compose.yml down";
      WorkingDirectory = "/home/tymscar/dotfiles/apps/nixos/docker/imgur-proxy";
      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
