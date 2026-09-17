{ config, pkgs, ... }:

{
# * sddm
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.desktopManager.plasma6.enable = true;

  # needed to have correct keyboard layout in sddm
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

# * tty
  console.keyMap = "de";

# * cups
  services.printing.enable = true;

# * audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

# * bluetooth
  hardware.bluetooth.enable = true;
}
