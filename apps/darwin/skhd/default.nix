{ pkgs, accountUsername, ... }:

let
  skhdrcContent =
    builtins.readFile ./skhdrc
    + ''
      cmd - return : /etc/profiles/per-user/${accountUsername}/bin/alacritty
    '';
in
{
  services.skhd = {
    enable = true;
    skhdConfig = skhdrcContent;
  };
  launchd.user.agents.skhd.serviceConfig = {
    StandardErrorPath = "/Users/${accountUsername}/Library/Logs/skhd.stderr.log";
    StandardOutPath = "/Users/${accountUsername}/Library/Logs/skhd.stdout.log";
  };
}
