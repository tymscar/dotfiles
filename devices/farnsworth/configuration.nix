{ pkgs, ... }:

{
  imports = [
    ../../common/nixos.nix
    ./hardware-configuration.nix
    ./secrets.nix
    ../../apps/nixos/docker
    ../../apps/nixos/b2-cleanup
  ];

  networking.firewall = {
    allowedTCPPorts = [
      2222
      3030
      5173
      5990
      8123
      11434
    ];
    allowedUDPPorts = [
      11434
    ];
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;
    };
  };

  systemd.services.homeassistant-vm = {
    description = "Home Assistant";
    after = [
      "network.target"
      "mnt-nas.mount"
    ];
    requires = [ "mnt-nas.mount" ];

    serviceConfig = {
      ExecStart = ''
        ${pkgs.qemu}/bin/qemu-system-x86_64 \
          -enable-kvm \
          -machine type=q35,accel=kvm \
          -cpu host \
          -smp 4 \
          -m 8192 \
          -drive if=pflash,format=raw,readonly=on,file=/run/libvirt/nix-ovmf/edk2-x86_64-code.fd \
          -drive file=/mnt/nas/homeassistant/disk-drive-efidisk0.qcow2,if=pflash,format=qcow2 \
          -drive file=/mnt/nas/homeassistant/disk-drive-scsi0.qcow2,format=qcow2,if=virtio \
          -netdev user,id=net0,hostfwd=tcp::8123-:8123 \
          -device virtio-net-pci,netdev=net0 \
          -device qemu-xhci,id=xhci \
          -device usb-host,bus=xhci.0,vendorid=0x10c4,productid=0xea60 \
          -device usb-host,bus=xhci.0,vendorid=0x0a5c,productid=0x21ec \
          -nographic
      '';
      Restart = "always";
      User = "root";
      Group = "kvm";
    };

    wantedBy = [ "multi-user.target" ];
  };

  swapDevices = pkgs.lib.mkForce [ ];

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

  environment.systemPackages = with pkgs; [
    nfs-utils
  ];

  systemd.services.docker = {
    after = [ "mnt-nas.mount" ];
    requires = [ "mnt-nas.mount" ];
  };

  virtualisation.docker.enable = true;
  users.users.tymscar = {
    extraGroups = [
      "docker"
      "kvm"
      "libvirtd"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCbCaPnHUAbLh2lZg4nkYEzAR7X1/b3KKhp/bQUgwwWzJOdHK9aJLFzUonWQaSkdwrCh3E3Lhd5mmxv4YQLiBXagNwGw+hzmrvsi6z1Oa/GpiE/BJPih4nrH62J+q7O8tSgD3JMW62j6Qjc1Qj75Acgan/kYMyIhXKX3ZfqEx4pvggM76HVVbRCfMuHtLE1qiqHTfCbb1ubiJixHWPFSRqaP1DLXpxFPC9Ztzp8A5TblC9dSTdbPPg9C/gSPsKGbJqz8+3Oa9HWmrfHbmsGkBGqvQSHl1T6mQlNTENxcDYkorsGIzg+4XlBne6FO47Gef6YCyOHS+qG0b3ZXL31mFTHDF/sCuPoaJcKjBy9iB40kiAQlceVtjYl2zG0toGDrmGHMoBvo/xOt/noqhUMrhRYDsGf4DVUnzpdDkqd+FDtIe7i8K7ejFmLK88LScr7/E8Ew730ecS6dVMRDMS84FIsSZ2WU1Ptz++DkBJsBPzTgtUN6qbO/jf3xWtn+cMqm/XpuMO+HNq2SCOKrbB9JIg0a8gBWmXsljIDlL+ppvR9WT+d9RNryCHbVF3QzbiPh7mIVEDKaCwmn9q5mzKqJW9/Kxq/DyTXmFdoexmYaIrKpjLqfAsM+1Ix2vPOwTZWiVCZr9cFoDOvxTEubgvQBTTtU/SLwNCunLhqHkcqDDrayw== openpgp:0xB8D50E7A"
    ];
  };

  services = {
    openssh = {
      ports = [ 22 ];
      settings = {
        PubkeyAuthentication = true;
        AllowUsers = [ "tymscar" ];
        UseDns = true;
        PermitRootLogin = "no";
      };
      extraConfig = "StreamLocalBindUnlink yes";
    };
  };
}
