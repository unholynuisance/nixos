{
  config,
  lib,
  pkgs,
  ...
} @ args: let
  cfg = config.modules.nixos.libvirt;
in {
  options.modules.nixos.libvirt = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [virt-manager];

    virtualisation.libvirtd = {
      enable = true;

      qemu = {
        ovmf.enable = true;
        swtpm.enable = true;

        runAsRoot = false;
      };
    };
  };
}
