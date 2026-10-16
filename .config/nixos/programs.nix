{ config, pkgs, ... }:

{
# * nix settings
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };

# * packages
  environment.systemPackages = with pkgs; [
# ** file management
    wget
    rclone
    p7zip
    eza
    zoxide
    file
    tree
    gparted
    cifs-utils

# ** system tools
    psmisc
    gnupg
    libnotify
    bluez
    openvpn
    pavucontrol

# ** terminal
    alacritty
    hyfetch

# ** window manager & compositor stuff
    xhost
    xkill
    hyprpaper
    hyprpolkitagent
    satty
    grim

# ** programming languages
    texliveFull
    python3

# ** programming tools
    just
    jupyter
    paraview

    emacs-gtk
    pdftk
    pandoc

# ** applications
    digikam
    gimp
    krita
    inkscape
    libreoffice
    spotify

  ];

# ** fonts
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    nerd-fonts.fira-code
    corefonts
  ];

# * programs
# ** system
  programs.git.enable = true;
  programs.fish.enable = true;
  programs.htop.enable = true;

  programs.nm-applet.enable = true;

# ** window manager & compositor
  programs.xwayland.enable = true;
  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  programs.noctalia.enable = true;

# ** programming
  programs.vim.enable = true;

# ** applications
  programs.firefox.enable = true;
  programs.thunderbird.enable = true;

}
