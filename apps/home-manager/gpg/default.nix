{ pkgs, specialArgs, ... }:
{
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

  programs.ssh = {
      enable = true;
      matchBlocks = {
        "*" = {
          forwardAgent = true;
          remoteForwards = [
             {
               bind.address = "/run/user/1000/gnupg/S.gpg-agent";
               host.address = "/Users/tymscar/.gnupg/S.gpg-agent.extra";
             }
             {
               bind.address = "/run/user/1000/gnupg/S.gpg-agent.ssh";
               host.address = "/Users/tymscar/.gnupg/S.gpg-agent.ssh";
             }
           ];
        };
      };
    };

  # Enable use of Yubikey for GPG and SSH via SmartCard.
  services.gpg-agent =
    if specialArgs.os == "linux" then
      {
        enable = true;
        enableSshSupport = true;
        enableZshIntegration = true;
        pinentryPackage = pkgs.pinentry-gnome3;
        defaultCacheTtl = 60;
        maxCacheTtl = 120;
      }
    else
      { };
}
