{ pkgs, ... }:

{
  imports = [
    ../../common/nixos.nix
    ./hardware-configuration.nix
    ../../apps/nixos/sunshine
    ../../apps/nixos/ollama
  ];

  networking.firewall = {
    allowedTCPPorts = [
      3030
      5173
      11434
    ];
    allowedUDPPorts = [
      11434
    ];
  };

  swapDevices = pkgs.lib.mkForce [ ];

  hardware = {
    pulseaudio.enable = false;
    opengl.enable = true;
    nvidia = {
      modesetting.enable = true;
    };
  };

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    xserver = {
      deviceSection = ''
        Option "ModeValidation" "AllowNonEdidModes"
        Option "CustomEDID" "DP-0:${./EdidForIphoneUltrawide.bin}"
      '';
      videoDrivers = [ "nvidia" ];
      displayManager = {
        sessionCommands = ''
          xrandr --output DP-3 --mode 480x1920 --pos 622x1518 --rotate left
          xrandr --output DP-0 --primary --mode 3440x1440 --rate 144 --pos 0x78 --rotate normal
          xrandr --output HDMI-0 --mode 3840x2160 --pos 3440x0 --rotate normal
        '';
      };
    };
  };
}
