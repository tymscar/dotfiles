{ pkgs, config, ... }:

{
  systemd.services.pihole-backup = {
    description = "Backup PiHole configuration";
    after = [ "network.target" "mnt-nas.mount" ];
    requires = [ "mnt-nas.mount" ];
    wants = [ "network.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = toString (pkgs.writeShellScript "pihole-backup" ''
        ${pkgs.sshpass}/bin/sshpass -f ${config.age.secrets.ssh-pihole-password.path} \
          ${pkgs.openssh}/bin/ssh root@10.0.0.11 'cd /root/backup && pihole-FTL --teleporter'
        
        ${pkgs.sshpass}/bin/sshpass -f ${config.age.secrets.ssh-pihole-password.path} \
          ${pkgs.openssh}/bin/scp -o StrictHostKeyChecking=no \
          'root@10.0.0.11:/root/backup/*.zip' /mnt/nas/pihole/
        
        ${pkgs.sshpass}/bin/sshpass -f ${config.age.secrets.ssh-pihole-password.path} \
          ${pkgs.openssh}/bin/ssh root@10.0.0.11 "rm /root/backup/*"
      '');
    };
  };

  systemd.timers.pihole-backup = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5min";
      OnUnitActiveSec = "2h";
      Persistent = true;
    };
  };
}
