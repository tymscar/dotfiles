{ ... }:

{
  services.ollama = {
    enable = true;
    listenAddress = "0.0.0.0:11434";
    acceleration = "cuda";
  };
}
