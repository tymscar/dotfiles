{ pkgs, lib, ... }:

{
  services = {
    dbus.packages = [ pkgs.gcr ];
    gnome.gnome-keyring.enable = lib.mkForce false;
    pcscd.enable = true;
  };
  hardware.gpgSmartcards.enable = true;
}
