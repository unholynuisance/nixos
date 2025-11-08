{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nuisance.modules.nixos.virtualisation.libvirt;
in
{
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
          swtpm.enable = true;
          runAsRoot = false;
        };
      };
    };

    networking.firewall.trustedInterfaces = [
      "virbr0"
    ];
  };
}
