{ pkgs, ... }:

{
  systemd.services.docker-create-proxy-network = {
    description = "Create Docker proxy network";
    after = [ "docker.service" ];
    requires = [ "docker.service" ];
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash -c '\
        if ! ${pkgs.docker}/bin/docker network ls --filter name=^proxy$ --format \"{{ .Name }}\" | grep -q ^proxy$; then \
          ${pkgs.docker}/bin/docker network create proxy; \
        fi'";
      ExecStop = "${pkgs.docker}/bin/docker network rm proxy";
      RemainAfterExit = true;
    };
    wantedBy = [ "multi-user.target" ];
  };
}
