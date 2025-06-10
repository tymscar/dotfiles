{ pkgs, config, ... }:
let
  docker-env = config.age.secrets.docker-authelia.path;
  WorkingDirectory = "/home/tymscar/dotfiles/apps/nixos/docker/authelia";
in {
  systemd.services.authelia = {
    description = "Authelia";
    after = [ "network.target" "docker.service" ];
    wants = [ "docker.service" ];
    serviceConfig = {
      inherit WorkingDirectory;
ExecStart = pkgs.writeShellScript "authelia-start" ''
  set -euo pipefail
  cd ${WorkingDirectory}/authelia

  cp users_database.yml .runtime-users_database.yml
  cp configuration.yml .runtime-configuration.yml

  set -a
  source ${docker-env}
  set +a

  ${pkgs.gnused}/bin/sed -i "s|PLACEHOLDER_PASSWORD_HASH|$TYMSCAR_PASSWORD_HASH|g" .runtime-users_database.yml
  ${pkgs.gnused}/bin/sed -i \
    -e "s|PLACEHOLDER_SESSION_SECRET|$AUTHELIA_SESSION_SECRET|g" \
    -e "s|PLACEHOLDER_STORAGE_KEY|$AUTHELIA_STORAGE_KEY|g" \
    .runtime-configuration.yml

  exec ${pkgs.docker}/bin/docker compose --env-file ${docker-env} -f ../docker-compose.yaml up --force-recreate
'';
      ExecStop = "${pkgs.docker}/bin/docker compose -f docker-compose.yaml down";

      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
