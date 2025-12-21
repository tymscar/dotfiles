{ accountUsername, ... }:
{
  age.secrets = {
    docker-librecounter.file = ../../secrets/docker/librecounter.age;
    docker-tymscar-website.file = ../../secrets/docker/tymscar-website.age;
    docker-tymscar-resume.file = ../../secrets/docker/tymscar-resume.age;
    docker-traefik.file = ../../secrets/docker/traefik.age;
    docker-linkfix.file = ../../secrets/docker/linkfix.age;
    docker-authelia.file = ../../secrets/docker/authelia.age;
    docker-atuin.file = ../../secrets/docker/atuin.age;
    docker-n8n.file = ../../secrets/docker/n8n.age;
    docker-grafana.file = ../../secrets/docker/grafana.age;
    docker-imgur-proxy.file = ../../secrets/docker/imgur-proxy.age;
    docker-immich.file = ../../secrets/docker/immich.age;
  };
}
