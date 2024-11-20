{ pkgs, ... }:

let
  fontFamily = "MonaspiceNe Nerd Font Propo";
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      general.import = with pkgs; [ alacritty-theme.aura ];
      window = {
        padding = {
          x = 12;
          y = 12;
        };
      };
      scrolling = {
        history = 99999;
      };
      font = {
        normal = {
          family = fontFamily;
          style = "Regular";
        };
        bold = {
          family = fontFamily;
          style = "Bold";
        };
        italic = {
          family = fontFamily;
          style = "Italic";
        };
        size = 11.0;
      };
      mouse = {
        bindings = [
          {
            mouse = "Middle";
            action = "PasteSelection";
          }
        ];
      };
    };
  };
}
