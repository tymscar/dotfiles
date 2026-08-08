{ pkgs, ... }:

{
  home.packages = [ pkgs."claude-code-bin" ];

  home.file.".claude/CLAUDE.md".source = ../agent-rules/AGENTS.md;
}
