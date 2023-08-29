{ pkgs, overrides ? { }, ... }:

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
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDI2Dde4RdoVd6xILo3lcL/PIUxY5OBMCPS6ABPLsSO60M8fDA/bScYVcRJBTKQzRYpVKv5lOLIqx+GS0Q3rX2YikLyUq2TARyU2fm3QTUeRqNNONBZo791ZWV7riU6YGj4Am7VRou513VwWPtyE5tLywtAIkaxG/gYvqz5oJK4n4izBGGO55hYUNa/fR7KCeX6s2dAh0ds9qwe94+vYEAhYz42M3f4f0QxH4vlVajUXY7JkdgwqVxKmztRONZPxKi7mEFjx0Ypx45f3p7qQm4kdnMnVbOqjxWTqPPli9qBHC1Uv0FINvxpLASSWR6al0JgYKnAQ5kkcdegPgPyEOgr tymscar@Bender"
    ];
  };

  networking.networkmanager.enable = true;

  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;

  systemd.tmpfiles.rules = [
    "f /home/tymscar/.hushlogin - - - - ''"
  ];

  security.sudo.wheelNeedsPassword = false;

  nixpkgs.config = { allowUnfree = true; };

  environment.systemPackages = with pkgs; [
    cifs-utils
    git
    killall
    lsof
    nixpkgs-fmt
    pciutils
    pinentry-gtk2
    wget
  ];

  system.stateVersion = "22.11";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
} // overrides
