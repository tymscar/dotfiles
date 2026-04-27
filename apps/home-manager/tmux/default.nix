{ pkgs, ... }:
let
  tmux-power = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-power";
    version = "2025-04-18";
    src = pkgs.fetchFromGitHub {
      owner = "wfxr";
      repo = "tmux-power";
      rev = "master";
      hash = "sha256-NRJcny3hCyqjp8SuzyC3Zc33rJqpUzs6rbWFgO8yb7c=";
    };
    rtpFilePath = "tmux-power.tmux";
  };
in
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    newSession = true;
    mouse = true;
    clock24 = true;
    historyLimit = 50000;
    prefix = "C-Space";
    keyMode = "vi";

    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      tmux-fzf
      prefix-highlight
      resurrect
      continuum
    ];

    extraConfig = ''
      set -sg escape-time 10
      set -g focus-events on

      # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
      set -g status-position bottom
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      # Repeatable pane navigation (prefix once, then tap h/j/k/l freely)
      bind -r h select-pane -L
      bind -r j select-pane -D
      bind -r k select-pane -U
      bind -r l select-pane -R

      # Repeatable window navigation
      bind -r n next-window
      bind -r p previous-window

      # Splits - layer 0 keys (v = below, b = beside)
      bind v split-window -v -c '#{pane_current_path}'
      bind b split-window -h -c '#{pane_current_path}'

      # New window in same directory
      bind c new-window -c '#{pane_current_path}'

      # Kill pane
      bind x kill-pane

      # Zoom (fullscreen toggle)
      bind z resize-pane -Z

      # Detach
      bind d detach-client

      # List all keybindings (help)
      bind ? list-keys

      # tmux-fzf: search everything (sessions, windows, panes, commands)
      bind / run-shell -b "${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf/main.sh"

      # Allow faster key repetition for -r bindings
      set -sg repeat-time 500

      # tmux-continuum: auto-save every 15 minutes, auto-restore on server start
      set -g @continuum-save-interval '15'
      set -g @continuum-restore-on-start 'true'

      # tmux-resurrect: restore programs
      set -g @resurrect-processes 'lazygit opencode'

      # tmux-power options (must be set before sourcing)
      set -g @tmux_power_theme '#96aa6e'
      set -g @tmux_power_g0 "#11140a"
      set -g @tmux_power_g1 "#1a1e12"
      set -g @tmux_power_g2 "#283020"
      set -g @tmux_power_g3 "#3a4230"
      set -g @tmux_power_g4 "#505a42"
      set -g @tmux_power_left_a '#{pane_current_path}'
      set -g @tmux_power_left_b '''
      set -g @tmux_power_right_y '#S'
      set -g @tmux_power_right_z '''
      set -g @tmux_power_prefix_highlight_pos 'LR'

      # Source tmux-power after options
      run-shell "${tmux-power}/share/tmux-plugins/tmux-power/tmux-power.tmux"
    '';
  };
}
