{ config, pkgs, lib, ... }:

let
  wallpaper = builtins.fetchurl {
    url = "https://cdn.osxdaily.com/wp-content/uploads/2017/12/classic-mac-os-tile-wallpapers-4.png";
    sha256 = "sha256:1mf6298l74ll251z2qrr9ld5mzn4ncgdr4sg5gz6h8sd39pzj5wz";
  };
in
{
  xsession.windowManager.i3 = {
    enable = true;

    config = {
      modifier = "Mod4";
      floating.modifier = "Mod4";

      keybindings = {
        "Mod4+w" = "kill";
        "Mod4+j" = "focus left";
        "Mod4+k" = "focus down";
        "Mod4+l" = "focus up";
        "Mod4+semicolon" = "focus right";
        "Mod4+Left" = "focus left";
        "Mod4+Down" = "focus down";
        "Mod4+Up" = "focus up";
        "Mod4+Right" = "focus right";
        "Mod4+Shift+h" = "move left";
        "Mod4+Shift+j" = "move down";
        "Mod4+Shift+k" = "move up";
        "Mod4+Shift+l" = "move right";
        "Mod4+Shift+Left" = "move left";
        "Mod4+Shift+Down" = "move down";
        "Mod4+Shift+Up" = "move up";
        "Mod4+Shift+Right" = "move right";
        "Mod4+h" = "split h";
        "Mod4+v" = "split v";
        "Mod4+f" = "fullscreen toggle";
        "Mod4+Shift+space" = "floating toggle";

        "Mod4+1" = "workspace number 1";
        "Mod4+2" = "workspace number 2";
        "Mod4+3" = "workspace number 3";
        "Mod4+4" = "workspace number 4";
        "Mod4+5" = "workspace number 5";
        "Mod4+6" = "workspace number 6";
        "Mod4+7" = "workspace number 7";
        "Mod4+8" = "workspace number 8";
        "Mod4+9" = "workspace number 9";
        "Mod4+0" = "workspace number 10";

        "Mod4+Shift+1" = "move container to workspace number 1";
        "Mod4+Shift+2" = "move container to workspace number 2";
        "Mod4+Shift+3" = "move container to workspace number 3";
        "Mod4+Shift+4" = "move container to workspace number 4";
        "Mod4+Shift+5" = "move container to workspace number 5";
        "Mod4+Shift+6" = "move container to workspace number 6";
        "Mod4+Shift+7" = "move container to workspace number 7";
        "Mod4+Shift+8" = "move container to workspace number 8";
        "Mod4+Shift+9" = "move container to workspace number 9";

        "Mod4+Shift+c" = "reload";
        "Mod4+Shift+r" = "restart";
        "Mod4+Shift+e" = "exec i3-nagbar -t warning -m 'Do you really want to exit i3?' -B 'Yes, exit' 'i3-msg exit'";
        "Mod4+space" = "exec rofi -show drun -show-icons";
        "Mod4+Return" = "exec alacritty";
        "Mod4+p" = "exec shutter";
        "Mod4+b" = "exec brave";
      };

      workspaceOutputAssign = [
        { workspace = "1"; output = "DP-0"; }
        { workspace = "2"; output = "DP-0"; }
        { workspace = "3"; output = "DP-0"; }
        { workspace = "4"; output = "DP-0"; }
        { workspace = "5"; output = "DP-0"; }
        { workspace = "6"; output = "HDMI-0"; }
        { workspace = "7"; output = "HDMI-0"; }
        { workspace = "8"; output = "HDMI-0"; }
        { workspace = "9"; output = "HDMI-0"; }
        { workspace = "10"; output = "DP-3"; }
      ];

      gaps = {
        inner = 10;
      };

      bars = [ ];

      startup = [
        { command = "systemctl --user restart polybar"; always = true; notification = false; }
        { command = "feh --bg-tile ${wallpaper} &"; always = true; notification = true; }
        { command = "sudo killall sunshine && sudo sunshine &"; always = true; notification = false; }
      ];
    };

    extraConfig = ''
      for_window [class=".shutter-wrapped"] floating enable
      for_window [class="Pcmanfm"] floating enable
      for_window [class="1Password"] floating enable
    '';
  };
}
