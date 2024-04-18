{ pkgs, device, ... }: {

  imports = [ ../../apps/darwin/homebrew ];
  environment.extraInit = ''
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)'';

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  fonts = {
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "Monaspace" "Noto" ]; })
      emacs-all-the-icons-fonts

    ];

    fontDir.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  security.pam.enableSudoTouchIdAuth = true;
  programs.zsh.enable = true;
  users.users.tymscar = {
    description = "Oscar Molnar";
    shell = pkgs.zsh;
    home = /Users/tymscar;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDI2Dde4RdoVd6xILo3lcL/PIUxY5OBMCPS6ABPLsSO60M8fDA/bScYVcRJBTKQzRYpVKv5lOLIqx+GS0Q3rX2YikLyUq2TARyU2fm3QTUeRqNNONBZo791ZWV7riU6YGj4Am7VRou513VwWPtyE5tLywtAIkaxG/gYvqz5oJK4n4izBGGO55hYUNa/fR7KCeX6s2dAh0ds9qwe94+vYEAhYz42M3f4f0QxH4vlVajUXY7JkdgwqVxKmztRONZPxKi7mEFjx0Ypx45f3p7qQm4kdnMnVbOqjxWTqPPli9qBHC1Uv0FINvxpLASSWR6al0JgYKnAQ5kkcdegPgPyEOgr tymscar@Bender"
    ];
  };
  networking.hostName = device;
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = 4;
  nixpkgs.hostPlatform = "aarch64-darwin";
}
