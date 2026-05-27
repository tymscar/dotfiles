{ pkgs, ... }:

let
  airpods-nc-toggle = pkgs.writeShellScriptBin "airpods-nc-toggle" ''
    osascript ${./nc-toggle.applescript}
  '';
in
{
  home.packages = [ airpods-nc-toggle ];

  xdg.configFile = {
    "karabiner/assets/complex_modifications/airpods_nc_toggle.json".text = builtins.toJSON {
      title = "AirPods NC Toggle - Nix managed";
      rules = [
        {
          description = "Map F23 to AirPods Noise Cancellation toggle";
          manipulators = [
            {
              type = "basic";
              from = {
                key_code = "f23";
              };
              to = [
                {
                  shell_command = "${airpods-nc-toggle}/bin/airpods-nc-toggle";
                }
              ];
            }
          ];
        }
      ];
    };
  };
}
