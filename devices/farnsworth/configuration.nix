{ pkgs, device, ... }:

let
  apple-color-emoji = pkgs.stdenv.mkDerivation {
    name = "apple-color-emoji";
    version = "16.4-patch.1";
    src = pkgs.fetchurl {
      url = "https://github.com/samuelngs/apple-emoji-linux/releases/download/v16.4-patch.1/AppleColorEmoji.ttf";
      sha256 = "15assqyxax63hah0g51jd4d4za0kjyap9m2cgd1dim05pk7mgvfm";
    };
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/share/fonts/truetype/apple-color-emoji
      cp $src $out/share/fonts/truetype/apple-color-emoji/AppleColorEmoji.ttf
    '';
  };
in
{
  imports = [
    ./hardware-configuration.nix
    ./secrets.nix
    ../../apps/nixos/gpg
    ../../apps/nixos/docker
  ];

  networking = {
    hostName = device;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        3030
        5173
        5990
        8123
        11434
      ];
      allowedUDPPorts = [
        53
        11434
      ];
    };
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;
      ovmf.packages = [ pkgs.OVMFFull.fd ];
    };
  };


  systemd.services.homeassistant-vm = {
    description = "Home Assistant";
    after = [ "network.target" ];

    serviceConfig = {
      ExecStart = ''
        ${pkgs.qemu}/bin/qemu-system-x86_64 \
          -enable-kvm \
          -machine type=q35,accel=kvm \
          -cpu host \
          -smp 4 \
          -m 8192 \
          -drive if=pflash,format=raw,readonly=on,file=/run/libvirt/nix-ovmf/OVMF_CODE.fd \
          -drive file=/home/tymscar/homeassistant/disk-drive-efidisk0.qcow2,if=pflash,format=qcow2 \
          -drive file=/home/tymscar/homeassistant/disk-drive-scsi0.qcow2,format=qcow2,if=virtio \
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

  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };

  programs.zsh.enable = true;
  programs.dconf.enable = true;

  fonts = {
    packages = with pkgs; [
      nerd-fonts.monaspace
      nerd-fonts.noto
      apple-color-emoji
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Monaspace" ];
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        emoji = [ "Apple Color Emoji" ];
      };
    };
  };

  virtualisation.docker.enable = true;
  users.users.tymscar = {
    extraGroups = [ "docker" "kvm" "libvirtd" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCbCaPnHUAbLh2lZg4nkYEzAR7X1/b3KKhp/bQUgwwWzJOdHK9aJLFzUonWQaSkdwrCh3E3Lhd5mmxv4YQLiBXagNwGw+hzmrvsi6z1Oa/GpiE/BJPih4nrH62J+q7O8tSgD3JMW62j6Qjc1Qj75Acgan/kYMyIhXKX3ZfqEx4pvggM76HVVbRCfMuHtLE1qiqHTfCbb1ubiJixHWPFSRqaP1DLXpxFPC9Ztzp8A5TblC9dSTdbPPg9C/gSPsKGbJqz8+3Oa9HWmrfHbmsGkBGqvQSHl1T6mQlNTENxcDYkorsGIzg+4XlBne6FO47Gef6YCyOHS+qG0b3ZXL31mFTHDF/sCuPoaJcKjBy9iB40kiAQlceVtjYl2zG0toGDrmGHMoBvo/xOt/noqhUMrhRYDsGf4DVUnzpdDkqd+FDtIe7i8K7ejFmLK88LScr7/E8Ew730ecS6dVMRDMS84FIsSZ2WU1Ptz++DkBJsBPzTgtUN6qbO/jf3xWtn+cMqm/XpuMO+HNq2SCOKrbB9JIg0a8gBWmXsljIDlL+ppvR9WT+d9RNryCHbVF3QzbiPh7mIVEDKaCwmn9q5mzKqJW9/Kxq/DyTXmFdoexmYaIrKpjLqfAsM+1Ix2vPOwTZWiVCZr9cFoDOvxTEubgvQBTTtU/SLwNCunLhqHkcqDDrayw== openpgp:0xB8D50E7A"
    ];
  };


  services = {
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PubkeyAuthentication = true;
        PasswordAuthentication = false;
        AllowUsers = [ "tymscar" ];
        UseDns = true;
        PermitRootLogin = "no";
      };
      extraConfig = "StreamLocalBindUnlink yes";
    };
    getty.autologinUser = "tymscar";
    xserver = {
      enable = true;
      desktopManager = {
        xterm.enable = false;
      };

      displayManager = {
        autoLogin.enable = true;
        autoLogin.user = "tymscar";
        lightdm = {
          enable = true;
          greeter.enable = false;
        };
      };
      windowManager.i3 = {
        enable = true;
      };
    };
  };
}
