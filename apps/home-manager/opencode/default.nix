{ pkgs, ... }:

{
  home.packages = [ pkgs.opencode ];

  xdg.configFile."opencode/AGENTS.md".source = ../agent-rules/AGENTS.md;

  xdg.configFile."opencode/opencode.json".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
    theme = "catppuccin";
  };
}
