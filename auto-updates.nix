{ ... }: {

  # Automatic updates, but don't reboot
  system.autoUpgrade = {
    flake = "github:tapszac/nixos-configs";
    enable = true;
    allowReboot = false;
    operation = "boot";
    dates = "weekly";
  };
}
