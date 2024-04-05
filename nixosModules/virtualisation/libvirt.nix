{ config, lib, pkgs, ... }@args:
let cfg = config.nuisance.modules.nixos.virtualisation.libvirt;
in {
  options.nuisance.modules.nixos.virtualisation.libvirt = {
    enable = lib.mkEnableOption "libvirt";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ virt-manager ];

    virtualisation = {
      spiceUSBRedirection.enable = true;

      libvirtd = {
        enable = true;

        qemu = {
          ovmf.enable = true;
          swtpm.enable = true;

          runAsRoot = false;
        };
      };
    };
  };
}
