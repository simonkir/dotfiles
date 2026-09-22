{ config, pkgs, ... }:

{
  users.users."simikir" = {
    isNormalUser = true;
    description = "simikir";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}

