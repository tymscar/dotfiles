{ pkgs, ... }:

{
  home.packages = [ pkgs."claude-code" ];

  home.file.".claude/CLAUDE.md".source = ../agent-rules/AGENTS.md;
}
