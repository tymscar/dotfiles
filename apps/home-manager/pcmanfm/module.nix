{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.pcmanfm;
in
{
  options.pcmanfm = {
    enable = mkEnableOption "pcmanfm";

    settings = mkOption {
      type = types.attrsOf (types.attrsOf types.str);
      default = {
        config = {
          bm_open_method = "0";
        };

        volume = {
          mount_on_startup = "1";
          mount_removable = "1";
          autorun = "1";
        };

        ui = {
          always_show_tabs = "1";
          max_tab_chars = "32";
          win_width = "1000";
          win_height = "1000";
          splitter_pos = "150";
          media_in_new_tab = "0";
          desktop_folder_new_win = "0";
          change_tab_on_drop = "1";
          close_on_unmount = "1";
          focus_previous = "0";
          side_pane_mode = "places";
          view_mode = "icon";
          show_hidden = "1";
          sort = "name;ascending;";
          toolbar = "newtab;navigation;home;";
          show_statusbar = "1";
          pathbar_mode_buttons = "0";
        };
      };
      description = "Configuration settings for pcmanfm.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.pcmanfm ];

    home.file.".config/pcmanfm/pcmanfm.conf".text =
      let
        pcmanfmINI = generators.toINI { } cfg.settings;
      in
      pcmanfmINI;
  };
}
