{ pkgs, hop, ... }:
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
      prefix-highlight
      resurrect
      continuum
    ];

    extraConfig = ''
      set -sg escape-time 10
      set -g focus-events on

      # Enter copy mode without the awkward prefix-[ (prefix Escape; [ still works)
      bind Escape copy-mode

      # Vim-style copy mode + copy to macOS clipboard (pbcopy)
      # tmux's vi default puts begin-selection on Space and rectangle-toggle on v;
      # rebind so v starts a selection and C-v toggles block select, like vim.
      bind -T copy-mode-vi v   send-keys -X begin-selection
      bind -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind -T copy-mode-vi y   send-keys -X copy-pipe-and-cancel "pbcopy"
      bind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "pbcopy"
      bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"

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

      # hop: project / branch / scratch launcher and session switcher
      bind / display-popup -E -w 80% -h 80% "${hop}/bin/hop"

      # Allow faster key repetition for -r bindings
      set -sg repeat-time 500

      # tmux-continuum: auto-save every 15 minutes, auto-restore on server start
      set -g @continuum-save-interval '15'
      set -g @continuum-restore-on-start 'true'

      # tmux-resurrect: restore programs
      set -g @resurrect-processes 'lazygit claude'

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
