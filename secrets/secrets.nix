let
  # when I want to add a new device, I should add a new entry here with the devices SSH pub key
  # and then I should rekey the secrets.age file using the agenix key stored in 1pass
  # nix run github:ryantm/agenix -- --rekey --identity /home/tymscar/.ssh/id_agenix  (assuming I have it saved there)
  one-password-agenix = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPeudL4pX9bw/g9apBN7uOBGjbqOJW/pxLKvZNiAMVWs";
  farnsworth = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAe9FWKQXgkfRiGEw8P1ajzg5vx4Wg8c/5gMOLAyEGua";
in
{
  # to edit the secrets file, just run
  # nix run github:ryantm/agenix -- -e secrets.age --identity /home/tymscar/.ssh/id_agenix
  # again, assuming thats where I keep the key stored in 1password
  # and secrets.age is the name of the secrets file
  "docker/tymscar-website.age".publicKeys = [
    one-password-agenix
    farnsworth
  ];
  "docker/tymscar-resume.age".publicKeys = [
    one-password-agenix
    farnsworth
  ];
  "docker/traefik.age".publicKeys = [
    one-password-agenix
    farnsworth
  ];
  "docker/linkfix.age".publicKeys = [
    one-password-agenix
    farnsworth
  ];
  "docker/authelia.age".publicKeys = [
    one-password-agenix
    farnsworth
  ];
  "docker/atuin.age".publicKeys = [
    one-password-agenix
    farnsworth
  ];
}
