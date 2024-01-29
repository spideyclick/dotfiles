#I've since uEdit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

# Main Config
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  # services.openvpn.servers = {
  #   home_vpn = {
  #     config = '' config /root/nixos/openvpn/home_vpn.conf '';
  #   };
  # };

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  # Enable the KDE Plasma Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Enable gnome keyring
  services.gnome.gnome-keyring.enable = true;

  # enable hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    enableNvidiaPatches = true;
  };
  # Optional, hint electron apps to use wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Use fish shell
  environment.shells = with pkgs; [ zsh ];

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.spideyclick = {
    isNormalUser = true;
    description = "Zachary";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    #  thunderbird
    ];
  };


  # home-manager.users.spideyclick = {
  #   /* The home.stateVersion option does not have a default and must be set */
  #   home.stateVersion = "18.09";
  #   /* Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ]; */
  #   programs.git = {
  #     enable = true;
  #     userName  = "spideyclick";
  #     userEmail = "spideyclick@gmail.com";
  #   };
  #   programs.zsh = {
  #     enable = true;
  #     shellAliases = {
  #       ll = "ls -l";
  #       update = "sudo nixos-rebuild switch";
  #     };
  #     histSize = 10000;
  #     histFile = "~/.zsh_history";
  #     ohMyZsh = {
  #       enable = true;
  #       plugins = [ "git" "thefuck" ];
  #       theme = "robbyrussell";
  #     };
  #   };
  # };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "spideyclick";

  # Auto Login without any display manager:
  # services.getty.autologinUser = "spideyclick";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Basic Utilities
    pkgs.bashmount
    pkgs.fd
    pkgs.git
    pkgs.killall
    pkgs.unzip
    pkgs.wl-clipboard

    # OS/UI
    grc
    pkgs.brightnessctl
    pkgs.hyprpaper
    pkgs.networkmanagerapplet
    pkgs.rofi-wayland
    pkgs.swww
    pkgs.waybar

    # Terminal/Shell
    pkgs.nerdfonts
    pkgs.kitty
    pkgs.wezterm
    pkgs.zellij
    pkgs.zsh
    pkgs.fish
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fzf
    fishPlugins.grc

    # Editors & Language Servers
    # The Nano editor is installed by default.
    pkgs.vscode
    pkgs.helix
    pkgs.marksman                 # Hints for linking between documents
    nodePackages_latest.cspell    # Just a spell checker
    nodePackages_latest.pyright   # Python LSP (very robust)
    pkgs.ruff-lsp                 # Python LSP written in Rust
    pkgs.lldb                     # Rust LLDB

    # File Management
    pkgs.gnome.nautilus

    # Browsers
    pkgs.brave
    pkgs.firefox

    # TUI Apps
    pkgs.bacon
    pkgs.broot
    pkgs.lazygit
    pkgs.ranger

    # GUI Apps
    (
      pkgs.writeShellScriptBin "discord" ''
        exec ${pkgs.discord}/bin/discord
          --enable-features=UseOzonePlatform
          --ozone-platform=wayland
      ''
    )
    pkgs.inkscape

    # Rust Development
    gcc
    rustup
  ];

  programs.fish.enable = true;
  fonts.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ]; })
  ];

  programs.zsh.enable = true;
  programs.zsh = {
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "vi-mode" ];
      theme = "robbyrussell";
    };
  };

  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];

  environment.sessionVariables.EDITOR = "hx";
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
  # I've since upgraded to 23.10

}
