{
  specialArgs,
  pkgs,
  ...
}:
{
  programs.ghostty = {
    enable = true;
    package = with pkgs; if specialArgs.os == "linux" then ghostty else ghostty-bin;
    settings = {
      "shell-integration" = "zsh";
      term = "xterm-256color";
      "clipboard-read" = "allow";
      "clipboard-write" = "allow";
      "copy-on-select" = false;
      "window-theme" = "system";
      "window-padding-x" = 20;
      "window-padding-y" = 20;
      "window-padding-balance" = true;
      "background-opacity" = 0.9;
      "background-blur-radius" = 20;
      background = "#11140a";
      foreground = "#f2f2f2";
      "selection-background" = "#869563";
      "selection-foreground" = "#f2f2f2";
      "cursor-color" = "#f2f2f2";
      "cursor-text" = "#11140a";
      "cursor-invert-fg-bg" = true;
      "cursor-style" = "bar";
      "cursor-style-blink" = true;
      palette = [
        "0=#090909"
        "1=#fcaeae"
        "2=#9de598"
        "3=#f2dc96"
        "4=#93c3f4"
        "5=#f799fd"
        "6=#88e9ec"
        "7=#d4d4d4"
        "8=#8d8d8d"
        "9=#ffc0c0"
        "10=#aaf3a5"
        "11=#ffe9a5"
        "12=#a2d0ff"
        "13=#fbafff"
        "14=#96f6fa"
        "15=#b9b9b9"
      ];
      "font-size" = 18.5;
      "font-family" = "MonaspiceNe Nerd Font Propo";
      "mouse-hide-while-typing" = true;
      "focus-follows-mouse" = true;
      "macos-titlebar-style" = "hidden";
      "macos-icon" = "xray";
      keybind = "shift+enter=text:\\r\\n";
    };
  };
}
