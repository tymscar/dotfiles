{ pkgs, config, extraPackages ? [ ], overrides ? { }, ... }:

{
  home.packages = with pkgs;
    [
      bat
      gnupg
      gotop
      htop
      lsd
      neofetch
      p7zip
      (jetbrains.plugins.addPlugins jetbrains.webstorm [ "github-copilot" ])
    ] ++ extraPackages;

  home.stateVersion = "22.11";
} // overrides
