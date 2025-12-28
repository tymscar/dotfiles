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
    docker-forgejo.file = ../../secrets/docker/forgejo.age;
    b2-account = {
      file = ../../secrets/b2/account.age;
      owner = accountUsername;
    };
    b2-key = {
      file = ../../secrets/b2/key.age;
      owner = accountUsername;
    };
    ssh-udr-password = {
      file = ../../secrets/ssh/udr-password.age;
      owner = accountUsername;
    };
    ssh-pihole-password = {
      file = ../../secrets/ssh/pihole-password.age;
      owner = accountUsername;
    };
  };
}
