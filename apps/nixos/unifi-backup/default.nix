{ pkgs, config, ... }:

{
  systemd.services.unifi-backup = {
    description = "Backup UniFi configuration from UDR";
    after = [
      "network.target"
      "mnt-nas.mount"
    ];
    requires = [ "mnt-nas.mount" ];
    wants = [ "network.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = toString (
        pkgs.writeShellScript "unifi-backup" ''
          ${pkgs.sshpass}/bin/sshpass -f ${config.age.secrets.ssh-udr-password.path} \
            ${pkgs.openssh}/bin/scp -o StrictHostKeyChecking=no \
            'root@10.0.0.1:/data/unifi/data/backup/autobackup/*.unf' /mnt/nas/unifi/
        ''
      );
    };
  };

  systemd.timers.unifi-backup = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5min";
      OnUnitActiveSec = "1h";
      Persistent = true;
    };
  };
}
