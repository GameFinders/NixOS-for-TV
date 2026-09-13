# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.timeout = 5;
  boot.loader.grub.extraConfig = ''
    set timeout_style=hidden
  '';
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.efi.canTouchEfiVariables = true;

  boot.plymouth = {
    enable = true;
    theme = "breeze";
  };

  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "NixOS-TV"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Istanbul";

  # Select internationalisation properties.
  i18n.defaultLocale = "tr_TR.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "tr_TR.UTF-8";
    LC_IDENTIFICATION = "tr_TR.UTF-8";
    LC_MEASUREMENT = "tr_TR.UTF-8";
    LC_MONETARY = "tr_TR.UTF-8";
    LC_NAME = "tr_TR.UTF-8";
    LC_NUMERIC = "tr_TR.UTF-8";
    LC_PAPER = "tr_TR.UTF-8";
    LC_TELEPHONE = "tr_TR.UTF-8";
    LC_TIME = "tr_TR.UTF-8";
  };

  # Disable the X11 windowing system?
  services = {
    xserver.enable = false;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    displayManager = {
      autoLogin = {
        enable = true;
        user = "tv-user";
      };
      defaultSession = "plasma-bigscreen-wayland";
    };
    displayManager.sessionPackages = [
      pkgs.kdePackages.plasma-bigscreen
    ];
    desktopManager.plasma6 = {
      enable = true;
    };
  };
  qt.enable = true;

  # Flatpak!
  services.flatpak.enable = true;

  # To enable NVIDIA drivers, uncomment this code:
  #hardware.graphics.enable = true;
  #services.xserver.videoDrivers = [ "nvidia" ];
  #hardware.nvidia = {
  #  modesetting.enable = true;
  #  powerManagement.enable = false;
  #  powerManagement.finegrained = false;
  #  open = true;
  #  nvidiaSettings = true;
  #  package = config.boot.kernelPackages.nvidiaPackages.stable;
  #};

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "tr";
    variant = "";
  };

  environment.etc."issue".text = ''
    NixOS [Unstable]
    ====================================
    Kernel version:     \r
    Machine name:       \m
    TTY Label:          \l
    System Description: \S
    
    Note: read the NixOS Wiki.
    It is now safe to log in.
  '';

  # sudo
  security.sudo.enable = true;

  # Configure console keymap
  console.keyMap = "trq";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."tv-user" = {
    isNormalUser = true;
    description = "Televizyon Kullanıcısı";
    extraGroups = [ "networkmanager" "wheel" "plugdev" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="04e8", MODE="0666", GROUP="plugdev"
  '';

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];

  # Bluetooth
  hardware.bluetooth.enable = true;

  # ZSH
  programs.zsh.enable = true;

  # upower & power-profiles-daemon
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  # moved to packages.nix

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
  networking.firewall.enable = false;

  # OpenRGB
  services.hardware.openrgb.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.11"; # Did you read the comment?

}
# This file is designed for use with Nixpkgs Unstable (NixOS 26.11). DO NOT TRY TO BACKPORT IT TO NIXPKGS STABLE (NixOS 26.05) as only Nixpkgs Unstable has kdePackages.plasma-bigscreen.
# Bu dosya, Nixpkgs Unstable (NixOS 26.11) ile kullanılmak üzere tasarlanmıştır. Bunu Nixpkgs Stable (NixOS 26.05) sürümüne geriye dönük olarak uyarlamaya çalışmayın; zira yalnızca Nixpkgs Unstable, kdePackages.plasma-bigscreen paketini içermektedir.
