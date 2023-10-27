{lib, ...}: rec {
  # Root
  mkDevices = {
    disks ? [],
    volumeGroups ? [],
  }: {
    disk = lib.attrsets.mergeAttrsList disks;
    lvm_vg = lib.attrsets.mergeAttrsList volumeGroups;
  };

  # Physical storage
  mkDisk = {
    name,
    device,
    partitions,
  }: {
    ${name} = {
      name = name;
      type = "disk";
      device = device;
      content = {
        type = "gpt";
        partitions = lib.attrsets.mergeAttrsList (builtins.map (p: p name) partitions);
      };
    };
  };

  # Abstract physical partitions
  mkPartition = {
    name,
    size,
    content,
  }: diskName: {
    ${name} = {
      label = "${diskName}-${name}";
      size = size;
      content = content diskName name;
    };
  };

  # Concrete physical partitions
  mkEfiPartition = {size}:
    mkPartition {
      name = "efi";
      size = size;
      content = diskName: name: {
        type = "filesystem";
        format = "vfat";
        mountpoint = "/efi";
        extraArgs = ["-n ${diskName}-${name}"];
      };
    };

  mkPhysicalVolumePartition = {
    size,
    vg,
  }:
    mkPartition {
      name = "pv";
      size = size;
      content = _: _: {
        type = "lvm_pv";
        vg = vg;
      };
    };

  # Logical storage
  mkVolumeGroup = {
    name,
    volumes,
  }: {
    ${name} = {
      type = "lvm_vg";
      lvs = lib.attrsets.mergeAttrsList (builtins.map (v: v name) volumes);
    };
  };

  # Abstract logical volumes
  mkVolume = {encrypt ? false, ...} @ args:
    (
      if encrypt
      then mkEncryptedVolume
      else mkUnencryptedVolume
    )
    args;

  mkUnencryptedVolume = {
    name,
    size,
    content,
    ...
  }: vgName: {
    "${name}vol" = {
      name = "${name}vol";
      size = size;
      content = content vgName name;
    };
  };

  mkEncryptedVolume = {
    name,
    size,
    content,
    unlock ? false,
    ...
  }: vgName: {
    "crypt${name}vol" = {
      name = "crypt${name}vol";
      size = size;
      content = {
        name = "${vgName}-${name}vol";
        type = "luks";
        extraFormatArgs = ["--label ${vgName}-crypt${name}"];
        passwordFile = "/tmp/${vgName}-crypt${name}-password";
        initrdUnlock = unlock;
        content = content vgName name;
      };
    };
  };

  # Concrete logical volumes
  mkBtrfsVolume = {
    name,
    size,
    subvolumes,
    encrypt ? false,
    unlock ? false,
  } @ args:
    mkVolume {
      inherit name size encrypt unlock;
      content = mkBtrfsContent {
        inherit subvolumes;
      };
    };

  mkBootVolume = {
    size,
    encrypt ? false,
    unlock ? false,
  }:
    mkBtrfsVolume {
      name = "boot";
      inherit size encrypt unlock;
      subvolumes = {
        "@" = {mountpoint = "/boot";};
      };
    };

  mkSwapVolume = {
    size,
    encrypt ? false,
    unlock ? false,
  }:
    mkVolume {
      name = "swap";
      inherit size encrypt unlock;
      content = mkSwapContent {};
    };

  # Content
  mkBtrfsContent = {subvolumes}: vgName: name: {
    type = "btrfs";
    extraArgs = ["--label ${vgName}-${name}"];
    subvolumes = subvolumes;
  };

  mkSwapContent = {}: vgName: name: {
    type = "swap";
  };
}
