{ config, pkgs, ... }:

{
# * nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.auto-optimise-store = true;

# * packages
  environment.systemPackages = with pkgs; [
    wget
    rclone
    p7zip
    eza
    just

    libnotify
    bluez
    openvpn
    pavucontrol
    gparted

    alacritty
    hyfetch

    hyprpaper
    hyprpolkitagent
    xkill
    satty
    grim

    texliveFull
    jupyter

    emacs-gtk
    pdftk
    pandoc

    digikam
    gimp
    krita
    inkscape
    libreoffice
    spotify

  ];

  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    nerd-fonts.fira-code
    corefonts
  ];

# * programs
  programs.git.enable = true;
  programs.fish.enable = true;
  programs.htop.enable = true;

  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  programs.noctalia.enable = true;

  programs.vim.enable = true;

  programs.firefox.enable = true;
  programs.thunderbird.enable = true;

}
