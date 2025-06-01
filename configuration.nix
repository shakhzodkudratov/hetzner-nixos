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
      openssh.authorizedKeys.keys = [
      lib.strings.concatStrings [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGU7pRKuTWfzRy8+"
        "Hb6vKz4+FNKfDzKA0HCLw+cxDCVXqsCBJPZXTfUZV1fxfBhfgn2IBO"
        "w99DbnmRaYeSm48ZB7V0xwqgM8Ucy2m4MJytvPbyjoEcfV434J3Xm+"
        "1R5P4tn5BvFPPseBBFrahsKXvakT07hiEJe6S28KuC3zvMN/cORfGu"
        "ViGuZRslRuT3ozd8pJtDcWSod5f3ek59qwYrC8KS8ljR7kBJWgdJvA"
        "OyifuDd9POh4TcbXOykcDqYKlZlWLnFoZcCE3QUcOAELyBffEtMFRd"
        "/4N+Mgwdf6Y4YjspHNDfnSKRgNQVH/zYBnIV9jt/umdAyN9Kby0v/E"
        "Gv9HI0Kb5t2/eCLPCDSyb4AQChb25xMTkGXcXcqIrLCWl6oR1/QfqU"
        "fuC8KJRp5Nj9saoi9pxtzAqU4/EXXL1EwYHaICK4LOYW+2la05Pv8w"
        "zX4ne9Xpoo0jJNCHioYacvJC1noWrDSmRU6oEhQqHKGBQU0drC/pYL"
        "mZhjAhi0JQE="
      ]
      ];
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

