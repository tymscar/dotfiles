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
    ../../apps/home-manager/neovim
    ../../apps/home-manager/alacritty
    ../../apps/home-manager/gpg
    ../../apps/home-manager/vscode
    ../../apps/home-manager/ssh
    # ../../apps/home-manager/zed #zed is broken on macos now
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
      '';
    }
  ];

  home.packages = with pkgs; [
    appcleaner
    bottom
    bruno
    cargo
    direnv
    git-lfs
    gitkraken
    gotop
    jetbrains.idea-ultimate
    #(jetbrains.plugins.addPlugins jetbrains.pycharm-professional [ "nixidea" "detekt" "com.facebook.ktfmt_idea_plugin" "com.github.copilot" "IdeaVIM" ]) # Not supported on macos yet
    nixfmt-rfc-style
    openssl
    pinentry_mac
    pyenv
    raycast
    readline
    shfmt
    slack
    sqlite
    tcl
    watchman
    xz
    zlib
  ];
}
