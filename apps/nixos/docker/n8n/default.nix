{ pkgs, config, ... }:

let
  dockerEnv = config.age.secrets.docker-n8n.path;
in
{
  systemd.services.n8n = {
    description = "n8n workflow automation";
    after = [
      "network.target"
      "docker.service"
      "mnt-nas.mount"
    ];
    requires = [ "mnt-nas.mount" ];
    wants = [ "docker.service" ];

    serviceConfig = {
      ExecStart = "${pkgs.docker}/bin/docker compose --env-file ${dockerEnv} -f docker-compose.yml up --force-recreate";
      ExecStop = "${pkgs.docker}/bin/docker compose -f docker-compose.yml down";
      WorkingDirectory = "/home/tymscar/dotfiles/apps/nixos/docker/n8n";
      Restart = "always";
    };

    wantedBy = [ "multi-user.target" ];
  };

  systemd.services.n8n-backup = {
    description = "Backup n8n PostgreSQL database";
    after = [
      "n8n.service"
      "docker.service"
      "mnt-nas.mount"
    ];
    requires = [
      "n8n.service"
      "mnt-nas.mount"
    ];
    wants = [ "docker.service" ];
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      EnvironmentFile = [ dockerEnv ];
    };
    script = ''
      ${pkgs.docker}/bin/docker exec n8n-postgres \
        pg_dump -U $POSTGRES_USER $POSTGRES_DB | \
        ${pkgs.gzip}/bin/gzip > \
        /mnt/nas/n8n/pgBackup/n8n-$(${pkgs.coreutils}/bin/date +%Y%m%d).sql.gz

      cd /mnt/nas/n8n/pgBackup
      ls -t n8n-*.sql.gz | tail -n +8 | xargs rm -f
    '';
  };

  systemd.timers.n8n-backup = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 03:00:00";
      Persistent = true;
    };
  };
}
