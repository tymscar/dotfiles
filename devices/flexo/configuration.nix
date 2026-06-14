{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [
    ../../common/nixos.nix
    ./hardware-configuration.nix
    ../../apps/nixos/llamacpp
    ../../apps/nixos/tesla-fan-control
  ];

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_6_6;

  services.xserver = {
    videoDrivers = [ "nvidia" ];
    displayManager = {
      lightdm.enable = lib.mkForce false;
      autoLogin.enable = lib.mkForce false;
    };
    windowManager.i3.enable = lib.mkForce false;
    desktopManager.xterm.enable = lib.mkForce false;
  };
  fileSystems."/mnt/nas" = {
    device = "truenas-nfs.tymscar.com:/mnt/oasis/services";
    fsType = "nfs";
    options = [
      "nfsvers=4"
      "_netdev"
      "auto"
      "nofail"
    ];
  };

  networking.firewall.allowedTCPPorts = [ 11434 ];

  services.openssh.settings.PasswordAuthentication = lib.mkForce true;

  hardware = {
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.legacy_535;
      nvidiaPersistenced = true;
    };
  };

  services.llamacpp = {
    enable = true;
    model = "/mnt/nas/llamacpp/model.gguf";
    mmproj = "/mnt/nas/llamacpp/mmproj-F16.gguf";
    host = "0.0.0.0";
    port = 11434;
    ngl = 99;
    contextSize = 131072;
    extraArgs = [
      "-ts"
      "1.0,1.0"
      "-np"
      "1"
    ];
  };

  environment.systemPackages = with pkgs; [
    nvtopPackages.nvidia
    tmux
    nfs-utils
  ];

}
