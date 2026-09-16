{ pkgs, ... }:
let
  pulseDot = import ../sidepulse/pulse-dot.nix { inherit pkgs; };
in
{
  home.packages = [ pkgs."claude-code-bin" ];

  home.file.".claude/CLAUDE.md".source = ../agent-rules/AGENTS.md;

  home.file.".claude/settings.json".text = builtins.toJSON {
    theme = "dark";
    hooks.Stop = [
      {
        hooks = [
          {
            type = "command";
            command = "${pulseDot}/bin/pulse-dot >/dev/null 2>&1 &";
            async = true;
          }
        ];
      }
    ];
  };
}

