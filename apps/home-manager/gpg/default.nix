{ config, pkgs, ... }: {
  programs.gpg = {
    enable = true;
    package = pkgs.gnupg;

    publicKeys = [
      # Yubikey
      {
        source = ./keys/0x9DF5EC82164F4127.pub;
        trust = "ultimate";
      }
    ];
  };

  # Enable use of Yubikey for GPG and SSH via SmartCard.
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
    pinentryPackage = pkgs.pinentry-gnome3;

    defaultCacheTtl = 60;
    maxCacheTtl = 120;
  };
}
