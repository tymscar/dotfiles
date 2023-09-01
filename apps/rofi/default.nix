{ config, ... }:

{
  programs.rofi = {
    enable = true;
    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        "*" = {
          background-color = mkLiteral "#282c33";
          text-color = mkLiteral "#8ca0aa";
          border-color = mkLiteral "#2e343f";
          width = mkLiteral "512px";
          spacing = mkLiteral "0";
        };

        "#inputbar" = {
          border = mkLiteral "0 0 1px 0";
          children = map mkLiteral [ "prompt" "entry" ];
        };

        "#prompt" = {
          padding = mkLiteral "16px";
          border = mkLiteral "0 1px 0 0";
        };

        "#textbox" = {
          background-color = mkLiteral "#2e343f";
          border = mkLiteral "0 0 1px 0";
          border-color = mkLiteral "#282C33";
          padding = mkLiteral "8px 16px";
        };

        "#entry" = {
          padding = mkLiteral "16px";
        };

        "#listview" = {
          cycle = false;
          margin = mkLiteral "0 0 -1px 0";
          scrollbar = false;
        };

        "#element" = {
          border = mkLiteral "0 0 1px 0";
          padding = mkLiteral "16px";
        };

        "#element selected" = {
          background-color = mkLiteral "#2e343f";
        };

      };
  };
}
