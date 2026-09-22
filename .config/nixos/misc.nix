{ config, pkgs, ... }:

{
# * networking
  networking = {
    networkmanager.enable = true;
    wireless.enable = true;

    firewall.enable = true;

    hostName = "nixos";
  };

# * locale
  time.timeZone = "Europe/Berlin";

  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocales = [ "de_DE.UTF-8/UTF-8" ];
    extraLocaleSettings = {
      LC_CTYPE = "en_US.UTF-8";
      LC_COLLATE = "de_DE.UTF-8";

      LC_ADDRESS = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MESSAGES = "en_US.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  };
}
