{ pkgs, config, extraPackages ? [ ], overrides ? { }, ... }:

{
  home.packages = with pkgs;
    [
      bat
      tree
      ripgrep
      gnupg
      gotop
      htop
      lsd
      neofetch
      p7zip
      jetbrains-mono
      (jetbrains.plugins.addPlugins jetbrains.webstorm [ "github-copilot" ])
    ] ++ extraPackages;

  home.stateVersion = "22.11";
} // overrides
