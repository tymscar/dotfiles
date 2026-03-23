{ pkgs, ... }:

{
  home.packages = [ pkgs.codex ];

  home.file.".codex/AGENTS.md".source = ../agent-rules/AGENTS.md;
}
