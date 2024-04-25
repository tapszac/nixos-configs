{ pkgs, ... }: {
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      font-awesome

      roboto-slab
      open-sans
      intel-one-mono

      ipafont
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Ipa Font" "Roboto Slab" ];
        sansSerif = [ "Ipa Font" "Open Sans" ];
        monospace = [ "Intel One Mono" ];
      };
    };
  };
}
