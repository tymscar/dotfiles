{ pkgs, config, ... }:
let
  docker-env = config.age.secrets.docker-immich.path;
in
{
  systemd.services.immich = {
    description = "Immich";
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
      WorkingDirectory = "/home/tymscar/dotfiles/apps/nixos/docker/immich";
      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
  };

  systemd.services.immich-backup = {
    description = "Backup Immich PostgreSQL database";
    after = [
      "immich.service"
      "docker.service"
      "mnt-nas.mount"
    ];
    requires = [
      "immich.service"
      "mnt-nas.mount"
    ];
    wants = [ "docker.service" ];
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      EnvironmentFile = [ docker-env ];
    };
    script = ''
      ${pkgs.docker}/bin/docker exec immich-postgres \
        pg_dump -U postgres immich | \
        ${pkgs.gzip}/bin/gzip > \
        /mnt/nas/immich/pgBackup/immich-$(${pkgs.coreutils}/bin/date +%Y%m%d).sql.gz

      cd /mnt/nas/immich/pgBackup
      ls -t immich-*.sql.gz | tail -n +8 | xargs rm -f
    '';
  };

  systemd.timers.immich-backup = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 03:00:00";
      Persistent = true;
    };
  };
}
