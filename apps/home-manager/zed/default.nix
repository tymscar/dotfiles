{ ... }:

{
  programs.zed-editor = {
    enable = true;
    userSettings = {
      theme = "Catppuccin Macchiato";
      features = {
        copilot = false;
      };
      telemetry = {
        metrics = false;
      };
      inlay_hints = {
        enabled = false;
      };
      buffer_font_family = "MonaspiceNe Nerd Font Propo";
      vim_mode = true;
      ui_font_size = 16;
      buffer_font_size = 16;
    };
    extensions = [ "nix" ];
  };
}
