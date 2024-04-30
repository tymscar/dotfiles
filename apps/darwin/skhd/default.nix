{ pkgs, ... }:

{
  services.skhd = {
    enable = true;
    skhdConfig = builtins.readFile ./skhdrc;
  };
  launchd.user.agents.skhd.serviceConfig = 
   {
    StandardErrorPath = "/Users/tymscar/Library/Logs/skhd.stderr.log";
    StandardOutPath = "/Users/tymscar/Library/Logs/skhd.stdout.log";
  };
}
