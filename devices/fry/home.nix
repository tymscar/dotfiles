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

flutterPackageSet = import (pkgs.path + "/pkgs/development/compilers/flutter") {
    callPackage = pkgs.callPackage;
    fetchzip = pkgs.fetchzip;
    fetchFromGitHub = pkgs.fetchFromGitHub;
    dart = pkgs.dart;
    lib = pkgs.lib;
    stdenv = pkgs.stdenv;
    useNixpkgsEngine = false;
  };

  oldDataJson = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/NixOS/nixpkgs/refs/heads/master/pkgs/development/compilers/flutter/versions/3_27/data.json";
      sha256 = "sha256-uHhLyGu413Peq/CdY8rSWEdyAwVKApq5rKSt6BeOXIU=";
    };
  oldData = lib.importJSON oldDataJson;
  oldLock = oldData.pubspecLock;

  customFlutter = flutterPackageSet.wrapFlutter (
    flutterPackageSet.mkFlutter {
      version       = "3.27.2";
      channel       = "stable";
      engineVersion = "e672b006cb34c921db85b8e2f482ed3144a4574b";
      flutterHash = "sha256-Ao3cLJcFK9Ex0vuzjmVx6On+qymRvprD6pX1kdaFx1s=";
      engineSwiftShaderRev  = "86cf34f50cbe5a9f35da7eedad0f4d4127fb8342";
      engineSwiftShaderHash = "sha256-v5TxmJvCbUh8norIWIVhPvlJDsuv2N6LON+x7e3ZkZA=";
      patches = [];
      enginePatches = [];
      engineHashes = { };
      dartVersion = "3.6.0";
      dartHash = {
       x86_64-linux = "sha256-Fte5Fvb2/pW7utKm+j5vVZbFX4Ex2uPWqUWYz+F9Tzc=";
       aarch64-linux = "sha256-GiZWwHEccyxM+nfYNyKTeHP4XuctQVR1Rba5bzZfi88=";
       x86_64-darwin = "sha256-47ch7I4jtYO2FPxa28sAbiNKvcyFCxwoZetwm7IeCrI=";
       aarch64-darwin = "sha256-BqqA1/jx+3vDY053H1klUhxlQernOWY+nFHdbFppcXM=";
      };
      artifactHashes = {
         universal = {
              aarch64-darwin = "sha256-v5TxmJvCbUh8norIWIVhPvlJDsuv2N6LON+x7e3ZkZA=";
         };
         web = {
           aarch64-darwin = "sha256-t4Bz5Rf8f3RbcTMVxIWs5VxGHfJ1BnaIMEZBc6qQyyI=";
         };
         ios = {
           aarch64-darwin = "sha256-slbTQoCczi/WZs0L76bp+jD8+oRdHaxlWAqTTvDEKpA=";
         };
         android = {
           aarch64-darwin = "sha256-7/S/u5NxA29F+FqM/T7+4QMaq6HKgdk/Frzrd5TmjnU=";
         };
         macos = {
           aarch64-darwin = "sha256-yN2KHz38FCO3XCRBciW+7NKrDeDT/1edYIeia48624g=";
         };
      };
      pubspecLock = oldLock;
    }
  );
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
    customFlutter
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
