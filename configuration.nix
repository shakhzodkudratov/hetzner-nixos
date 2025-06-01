{ pkgs, lib, ... }:
{
  nix.settings = {
    experimental-features = "nix-command flakes";
  };
  
  environment.systemPackages = [
    pkgs.vim
    pkgs.git
  ];
  
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "ext4";
  };
  swapDevices = [
    {
      device = "/dev/disk/by-label/swap";
    }
  ];
  
  time.timeZone = "Asia/Tashkent";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";
  
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "ext4" ];
  
  users.users = {
    root.hashedPassword = "!"; # Disable root login
    shakhzod = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = lib.strings.splitString "\n" (
        builtins.readFile (
          builtins.fetchurl {
            url = "https://github.com/shakhzodkudratov.keys";
            sha256 = "0gnabwywc19947a3m4702m7ibhxmc5s4zqbhsydb2wq92k6qgh6g";
          }
        )
      );
    };
  };
  
  security.sudo.wheelNeedsPassword = false;
  
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };
  
  networking.firewall.allowedTCPPorts = [ 22 ];
  
  system.stateVersion = "25.05";
}

