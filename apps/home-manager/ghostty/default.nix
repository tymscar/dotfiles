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
      "cursor-style" = "bar";
      "cursor-style-blink" = true;
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
