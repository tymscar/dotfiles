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
  daktari = import ../../packages/daktari.nix { inherit pkgs; };
  pinnedJDK = pkgs.jdk21;
  gdk = pkgs.google-cloud-sdk.withExtraComponents( with pkgs.google-cloud-sdk.components; [
      gke-gcloud-auth-plugin
#      cloud_sql_proxy
  ]);

  bruno-wrapped = pkgs.writeShellScriptBin "bruno" ''
    export NODE_EXTRA_CA_CERTS="$(${pkgs.mkcert}/bin/mkcert -CAROOT)/rootCA.pem"
    exec open "${pkgs.bruno}/Applications/Bruno.app" "$@"
  '';
in
{
  imports = [
    ../../common/home.nix
    ../../apps/darwin/wallpaper
    ../../apps/darwin/karabiner
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
      initContent = ''
        ${defaultZsh.programs.zsh.initContent}
        eval "$(direnv hook zsh)"
        export USE_GKE_GCLOUD_AUTH_PLUGIN=True
        export ANDROID_NDK_HOME=$HOME/Library/Android/sdk/ndk/26.1.10909125
        export ANDROID_HOME=$HOME/Library/Android/sdk
        export PATH=$ANDROID_NDK_HOME:$PATH
        export JAVA_HOME=${pinnedJDK}
        alias cloud_sql_proxy=cloud-sql-proxy
        alias bash=zsh
      '';
    }
  ];

  home.packages = with pkgs; [
    _1password-cli
    daktari
    gdk
    google-cloud-sql-proxy
    mkcert
    pre-commit
    pinnedJDK
    go-task
    detekt
    visualvm
    nodejs_20
    postgresql
    yarn
    appcleaner
    bottom
    bruno-wrapped 
    cargo
    cmake
    direnv
    docker-credential-gcr
    fastlane
    git-lfs
    gitkraken
    gotop
    ninja
    nvtopPackages.apple
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
