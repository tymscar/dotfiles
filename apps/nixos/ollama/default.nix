{ ... }:

{
  services.ollama = {
    enable = true;
    host = "0.0.0.0";
    port = 11434;
    acceleration = "cuda";
  };
}
