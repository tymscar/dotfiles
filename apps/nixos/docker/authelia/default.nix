{ pkgs, config, ... }:
let
  docker-env = config.age.secrets.docker-authelia.path;
  WorkingDirectory = "/home/tymscar/dotfiles/apps/nixos/docker/authelia";
in
{
  systemd.services.authelia = {
    description = "Authelia";
    after = [
      "network.target"
      "docker.service"
      "mnt-nas.mount"
    ];
    requires = [ "mnt-nas.mount" ];
    wants = [ "docker.service" ];
    serviceConfig = {
      inherit WorkingDirectory;
      ExecStart = pkgs.writeShellScript "authelia-start" ''
        set -euo pipefail

        cp ${WorkingDirectory}/users_database.yml /mnt/nas/authelia/.runtime-users_database.yml
        cp ${WorkingDirectory}/configuration.yml /mnt/nas/authelia/.runtime-configuration.yml

        set -a
        source ${docker-env}
        set +a

        ${pkgs.gnused}/bin/sed -i "s|PLACEHOLDER_PASSWORD_HASH|$TYMSCAR_PASSWORD_HASH|g" /mnt/nas/authelia/.runtime-users_database.yml
        ${pkgs.gnused}/bin/sed -i \
          -e "s|PLACEHOLDER_SESSION_SECRET|$AUTHELIA_SESSION_SECRET|g" \
          -e "s|PLACEHOLDER_STORAGE_KEY|$AUTHELIA_STORAGE_KEY|g" \
          /mnt/nas/authelia/.runtime-configuration.yml

        exec ${pkgs.docker}/bin/docker compose --env-file ${docker-env} -f ${WorkingDirectory}/docker-compose.yaml up --force-recreate
      '';
      ExecStop = "${pkgs.docker}/bin/docker compose -f docker-compose.yaml down";

      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
