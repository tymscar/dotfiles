{ config, pkgs, overrides ? { }, ... }:

{
  boot.loader = {
    systemd-boot.enable = true;
    efi = { canTouchEfiVariables = true; };
  };

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  users.users.tymscar = {
    isNormalUser = true;
    description = "Oscar Molnar";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  networking.networkmanager.enable = true;

  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;

  nixpkgs.config = { allowUnfree = true; };

  environment.systemPackages = with pkgs; [
    cifs-utils
    git
    killall
    lsof
    nixpkgs-fmt
    pciutils
    pinentry-gtk2
    vim
    wget
  ];

  system.stateVersion = "22.11";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
} // overrides
