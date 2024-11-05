{ pkgs, modulesPath, lib, ... }:
let
  brunch = pkgs.fetchzip {
    url = "https://github.com/sebanc/brunch/releases/download/r129-stable-20241028/brunch_r129_stable_20241028.tar.gz";
    name = "brunch";
    hash = "sha256-v/EzgwdJQTOZx5MkXeF96yxIIYtOFCSfQQknIPsztGY=";

    stripRoot = false;
  };

  chromeos = pkgs.fetchzip {
    url = "https://dl.google.com/dl/edgedl/chromeos/recovery/chromeos_16033.43.0_rammus_recovery_stable-channel_mp-v5.bin.zip";
    name = "chromeos";
    hash = "sha256-VIz2fi88voc4ohaUHDEQn5wiLKmyFQydbfO/QzwU59E=";

    stripRoot = false;
  };

  artifacts = pkgs.runCommandNoCC "pack" {} ''
     mkdir $out

     cp -f ${brunch}/* $out
     cp -f ${chromeos}/*.bin  $out/chromeos.bin
  '';
in
{

  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  environment.systemPackages = [
    pkgs.vboot_reference pkgs.figlet pkgs.pv

    (pkgs.writeScriptBin "install-chromeos" ''
      sudo bash ${artifacts}/chromeos-install.sh -src ${artifacts}/chromeos.bin -dst $1
    '')
  ];
}

