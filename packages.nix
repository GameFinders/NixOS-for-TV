# packages.nix file
# Designed to be used with nix-add commands from GitHub repo "GameFinders/Imperative-to-Declarative-Nix".
# It includes VLC, Firefox, KDE Connect, and Plasma Bigscreen.

# packages.nix dosyası
# "GameFinders/Imperative-to-Declarative-Nix" adlı GitHub deposundaki nix-add komutlarıyla kullanılmak üzere tasarlanmıştır.
# VLC, Firefox, KDE Connect ve Plasma Bigscreen'i içerir.
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    #vim # Don't forget to uncomment this in Nano!
         # or to exit nano, use ^O, enter, then ^X.
         # to exit Vim, use ":qa!" to quit without saving, or use
         # ":wqa!" to save then quit.
         # Or use Shift+ZQ to quit and Shift+ZZ to save then quit.

         # Nano'da bunun yorum satırı işaretini kaldırmayı unutmayın!
         # veya nano'dan çıkmak için ^O, Enter ve ardından ^X tuşlarını kullanın.
         # Vim'den çıkmak için kaydetmeden çıkmak üzere ":qa!" komutunu veya kaydedip çıkmak üzere ":wqa!" komutunu kullanın.
         # Veya çıkmak için Shift+ZQ, kaydedip çıkmak için Shift+ZZ tuşlarını kullanın.
    vlc
    firefox
    kdePackages.kdeconnect-kde
    kdePackages.plasma-bigscreen
  ];
}

# This file is designed for use with Nixpkgs Unstable (NixOS 26.11). DO NOT TRY TO BACKPORT IT TO NIXPKGS STABLE (NixOS 26.05) as only Nixpkgs Unstable has kdePackages.plasma-bigscreen.
# Bu dosya, Nixpkgs Unstable (NixOS 26.11) ile kullanılmak üzere tasarlanmıştır. Bunu Nixpkgs Stable (NixOS 26.05) sürümüne geriye dönük olarak uyarlamaya çalışmayın; zira yalnızca Nixpkgs Unstable, kdePackages.plasma-bigscreen paketini içermektedir.
