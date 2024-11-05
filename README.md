# ChromeOS Installer

## Host env.

Nix Package manager is required. Following commands only work on Nix based system.

## Build ISO file

```bash
~> nix-shell -p nixos-generators
~> nixos-generate --format iso --configuration ./default.nix
```
## Flash and boot

```bash
~> sudo dd if=./result/iso/nixos*.iso of=/dev/<USB> bs=8M status=progress
```

Boot from USB stick, one booted, run:

```bash
~> sudo -i
~# install-chromeos /dev/<disk>
```

Type 'yes' to start installation.

## !Note

* It might take sometime due to the size of artifacts ([ChromeOS recovery image](https://cros.tech/device/shyvana/) and [Brunch](https://github.com/sebanc/brunch)).
* Current config works with Intel Gen8, others might not work!
* The script tends to pack existing artifacts to create a convinience, I have no reposibility if any damage to your devices, use with your own risk.

