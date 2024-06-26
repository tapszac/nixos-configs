{ pkgs, ... }: {

  services.greetd = {
    enable = true;
    settings = {
      default_session.command = ''
        ${pkgs.greetd.tuigreet}/bin/tuigreet \
        --time \
        --asterisks \
        --user-menu \
        --cmd "sway --unsupported-gpu"
      '';
    };
  };

  environment.etc."greetd/environments".text = "sway";
}
