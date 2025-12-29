{ pkgs, config, ... }:
let
  docker-env = config.age.secrets.docker-atuin.path;
in
{
  systemd.services.atuin = {
    description = "Atuin";
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
      WorkingDirectory = "/home/tymscar/dotfiles/apps/nixos/docker/atuin";
      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
  };

  systemd.services.atuin-backup = {
    description = "Backup Atuin PostgreSQL database";
    after = [
      "atuin.service"
      "docker.service"
      "mnt-nas.mount"
    ];
    requires = [
      "atuin.service"
      "mnt-nas.mount"
    ];
    wants = [ "docker.service" ];
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      EnvironmentFile = [ docker-env ];
    };
    script = ''
      ${pkgs.docker}/bin/docker exec atuin-postgresql \
        pg_dump -U $ATUIN_DB_USERNAME $ATUIN_DB_NAME | \
        ${pkgs.gzip}/bin/gzip > \
        /mnt/nas/atuin/pgBackup/atuin-$(${pkgs.coreutils}/bin/date +%Y%m%d).sql.gz

      cd /mnt/nas/atuin/pgBackup
      ls -t atuin-*.sql.gz | tail -n +8 | xargs rm -f
    '';
  };

  systemd.timers.atuin-backup = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 03:00:00";
      Persistent = true;
    };
  };
}
