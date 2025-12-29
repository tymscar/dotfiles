{ pkgs, config, ... }:

let
  docker-env = config.age.secrets.docker-forgejo.path;
in
{
  systemd.services.forgejo = {
    description = "Forgejo git server";
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
      WorkingDirectory = "/home/tymscar/dotfiles/apps/nixos/docker/forgejo";
      Restart = "always";
    };

    wantedBy = [ "multi-user.target" ];
  };

  systemd.services.forgejo-backup = {
    description = "Backup Forgejo PostgreSQL database";
    after = [
      "forgejo.service"
      "docker.service"
      "mnt-nas.mount"
    ];
    requires = [
      "forgejo.service"
      "mnt-nas.mount"
    ];
    wants = [ "docker.service" ];
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      EnvironmentFile = [ docker-env ];
    };
    script = ''
      ${pkgs.docker}/bin/docker exec forgejo-postgres \
        pg_dump -U $POSTGRES_USER $POSTGRES_DB | \
        ${pkgs.gzip}/bin/gzip > \
        /mnt/nas/forgejo/pgBackup/forgejo-$(${pkgs.coreutils}/bin/date +%Y%m%d).sql.gz

      cd /mnt/nas/forgejo/pgBackup
      ls -t forgejo-*.sql.gz | tail -n +8 | xargs rm -f
    '';
  };

  systemd.timers.forgejo-backup = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 03:00:00";
      Persistent = true;
    };
  };
}
