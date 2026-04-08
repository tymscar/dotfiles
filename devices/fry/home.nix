{
  pkgs,
  lib,
  specialArgs,
  accountUsername,
  ...
}:

let
  pinnedJDK = pkgs.jdk21;
  androidSdk = "/Users/${accountUsername}/Library/Android/sdk";
  androidNdk = "${androidSdk}/ndk/26.1.10909125";
  gdk = pkgs.google-cloud-sdk.withExtraComponents (
    with pkgs.google-cloud-sdk.components;
    [
      gke-gcloud-auth-plugin
      #      cloud_sql_proxy
    ]
  );

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
    ../../apps/home-manager/claude-code
    ../../apps/home-manager/codex
    ../../apps/home-manager/opencode
    ../../apps/home-manager/idea
    ../../apps/home-manager/ghostty
    ../../apps/home-manager/vscode
    ../../apps/home-manager/ssh
    ../../apps/home-manager/tmux
  ];

  programs.zsh.initContent = lib.mkAfter ''
    eval "$(direnv hook zsh)"
    alias cloud_sql_proxy=cloud-sql-proxy
    alias bash=zsh
  '';

  home.sessionVariables = {
    USE_GKE_GCLOUD_AUTH_PLUGIN = "True";
    ANDROID_HOME = androidSdk;
    ANDROID_SDK_ROOT = androidSdk;
    ANDROID_NDK_HOME = androidNdk;
    JAVA_HOME = "${pinnedJDK}";
  };

  home.sessionPath = [
    "${androidSdk}/emulator"
    "${androidSdk}/platform-tools"
    "${androidSdk}/cmdline-tools/latest/bin"
    androidNdk
  ];

  home.packages = with pkgs; [
    _1password-cli
    gdk
    google-cloud-sql-proxy
    mkcert
    pre-commit
    coreutils
    jq
    pinnedJDK
    go-task
    detekt
    visualvm
    nodejs-slim
    postgresql
    pnpm
    appcleaner
    bottom
    bruno-wrapped
    cmake
    direnv
    docker-credential-gcr
    fastlane
    git-lfs
    gitkraken
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
