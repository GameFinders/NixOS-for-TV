# NixOS for Televisions

Plasma Bigscreen included.

To deploy, copy this repo before running nixos-install:


```
[nixos@nixos:~]$ sudo -i
[root@nixos:/home/nixos]# cfdisk /dev/X && mkfs.fat -F 32 /dev/X1 && mkfs.ext4 -L "TV Root" /dev/X2
[root@nixos:/home/nixos]# mount /dev/X2 /mnt && mkdir /mnt/boot /mnt/boot/efi && mount /dev/X1 /mnt/boot/efi
[root@nixos:/home/nixos]# cd /mnt/etc/nixos
[root@nixos:/mnt/etc/nixos]# nixos-generate-config --root /mnt
[root@nixos:/mnt/etc/nixos]# rm -rf ./configuration.nix
[root@nixos:/mnt/etc/nixos]# curl -fLO https://raw.githubusercontent.com/GameFinders/NixOS-for-TV/main/configuration.nix && curl -fLO https://raw.githubusercontent.com/GameFinders/NixOS-for-TV/main/packages.nix
[root@nixos:/mnt/etc/nixos]# nixos-install
[root@nixos:/mnt/etc/nixos]# nixos-enter
[root@nixos:/]# passwd tv-user
[root@nixos:/]# exit
[root@nixos:/mnt/etc/nixos]# systemctl reboot
```

# How to install it

see above. enter the commands entered. X represents your /dev/sda, /dev/nvme0n1, etc.

if /dev/nvme0n1 etc., use p1 instead of 1 and p2 instead of 2.

# Why WTFPL

i had no idea what license to use.
