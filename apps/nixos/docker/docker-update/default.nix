{
  pkgs,
  lib,
  config,
  ...
}:
let
  stacks = lib.filterAttrs (
    _: service:
    lib.hasPrefix "/home/tymscar/dotfiles/apps/nixos/docker/" (
      service.serviceConfig.WorkingDirectory or ""
    )
  ) config.systemd.services;
in
{
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "docker-update" (
      lib.concatStrings (
        lib.mapAttrsToList (name: service: ''
          echo "== ${name}"
          cd ${service.serviceConfig.WorkingDirectory}
          docker compose pull --quiet --ignore-buildable
          systemctl restart ${name}.service
        '') stacks
      )
    ))
  ];
}
