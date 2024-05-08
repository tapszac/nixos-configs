{ pkgs, ... }: {
  systemd.services.update-flake-lock = {
    serviceConfig = { Type = "oneshot"; User = "zac"; };
    path = with pkgs; [ git openssh ];
    # Requires SSH key to be setup with remote
    script = ''
      cd /home/zac/nixos-configs
      git pull
      /run/current-system/sw/bin/nix flake update
      git add .
      git commit -m "update lock & backup config"
      git push origin main
    '';
  };
  systemd.timers.update-flake-lock = {
    wantedBy = [ "timers.target" ];
    partOf = [ "update-flake-lock.service" ];
    timerConfig = {
      OnCalendar = "weekly";
      Unit = "update-flake-lock.service";
      Persistent = true;
    };
  };
}
