{ pkgs, ... }:

{
  home.packages = [ pkgs.opencode ];

  xdg.configFile."opencode/AGENTS.md".source = ../agent-rules/AGENTS.md;
}
