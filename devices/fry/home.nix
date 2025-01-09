{
  pkgs,
  lib,
  specialArgs,
  accountUsername,
  ...
}:

let
  defaultZsh = import ../../apps/home-manager/zsh/default.nix {
    inherit
      pkgs
      lib
      specialArgs
      accountUsername
      ;
  };
in
{
  imports = [
    ../../common/home.nix
    ../../apps/darwin/wallpaper
    ../../apps/home-manager/git
    ../../apps/home-manager/idea
    ../../apps/home-manager/neovim
    ../../apps/home-manager/ghostty
    ../../apps/home-manager/gpg
    ../../apps/home-manager/vscode
    ../../apps/home-manager/ssh
  ];

  programs.zsh = lib.mkMerge [
    defaultZsh.programs.zsh
    {
      initExtra = ''
        ${defaultZsh.programs.zsh.initExtra}
        . $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh
        . ~/.asdf/plugins/java/set-java-home.zsh
        eval "$(direnv hook zsh)"
        export USE_GKE_GCLOUD_AUTH_PLUGIN=True
        export ANDROID_NDK_HOME=$HOME/Library/Android/sdk/ndk/26.1.10909125
        export ANDROID_HOME=$HOME/Library/Android/sdk
        export PATH=$ANDROID_NDK_HOME:$PATH
      '';
    }
  ];

  home.packages = with pkgs; [
    appcleaner
    bottom
    bruno
    cargo
    cmake
    direnv
    fastlane
    git-lfs
    gitkraken
    gotop
    ninja
    openssl
    pinentry_mac
    pyenv
    raycast
    readline
    shfmt
    slack
    sqlite
    tcl
    utm
    watchman
    xz
    zlib
  ];
}
