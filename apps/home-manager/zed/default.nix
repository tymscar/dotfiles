{ ... }:

{
  programs.zed-editor = {
    enable = true;
    userSettings = {
      features = { copilot = false; };
      telemetry = { metrics = false; };
      vim_mode = true;
    };
    extensions = [ "nix" ];
  };
}
