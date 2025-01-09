{ specialArgs, ... }:

{
  programs.ghostty = {
      enable = specialArgs.os == "linux";
      settings = builtins.fromJSON (builtins.readFile ./config.json);
  };
  home.file.".config/ghostty/config".text = builtins.readFile ./config;
}