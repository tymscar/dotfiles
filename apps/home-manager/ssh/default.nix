{ ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        ForwardAgent = true;
        IgnoreUnknown = "UseKeychain";
        UseKeychain = "yes";
      };
      "git.tymscar.com" = {
        HostName = "git.tymscar.com";
        Port = 2222;
      };
    };
  };
}
