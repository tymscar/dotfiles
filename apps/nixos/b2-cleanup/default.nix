{ pkgs, ... }:

{
  systemd.services.b2-cleanup = {
    description = "Clean up old B2 file versions";
    serviceConfig = {
      Type = "oneshot";
      User = "tymscar";
      ExecStart = toString (pkgs.writeShellScript "b2-cleanup" ''
        ${pkgs.rclone}/bin/rclone cleanup b2:tymscar-truenas-services
        ${pkgs.rclone}/bin/rclone cleanup b2:tymscar-truenas-important
      '');
    };
  };

  systemd.timers.b2-cleanup = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5min";
      OnUnitActiveSec = "15min";
      Persistent = true;
    };
  };
}
