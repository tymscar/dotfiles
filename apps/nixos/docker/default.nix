{ ... }:

{
  imports = [
    ./proxy-docker-network
    ./traefik
    ./dashy
    ./audiobookshelf
    ./changedetection
    ./microbin
    ./authelia
    ./uptimekuma
    ./linkfix
    ./openwebui
    ./tymscar-website
    ./resume
    ./atuin
    ./n8n
  ];

  virtualisation.docker.enable = true;
}
