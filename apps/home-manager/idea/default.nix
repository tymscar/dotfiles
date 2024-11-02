{
  pkgs,
  lib,
  ...
}:
let
  fetchPluginSrc =
    { url, hash }:
    let
      isJar = lib.hasSuffix ".jar" url;
      fetcher = if isJar then pkgs.fetchurl else pkgs.fetchzip;
    in
    fetcher {
      executable = isJar;
      inherit url hash;
    };

  downloadPlugin =
    {
      name,
      version,
      url,
      hash,
    }:
    let
      isJar = lib.hasSuffix ".jar" url;
      installPhase =
        if isJar then
          ''
            runHook preInstall
            mkdir -p $out && cp $src $out
            runHook postInstall
          ''
        else
          ''
            runHook preInstall
            mkdir -p $out && cp -r . $out
            runHook postInstall
          '';
    in
    pkgs.stdenv.mkDerivation {
      inherit name version;
      src = fetchPluginSrc { inherit url hash; };
      dontUnpack = isJar;
      inherit installPhase;
    };

  detekt = downloadPlugin {
    name = "detekt";
    version = "2.4.2";
    url = "https://downloads.marketplace.jetbrains.com/files/10761/621940/Detekt_IntelliJ_Plugin-2.4.2.zip";
    hash = "sha256-9dGFZkrovtu7vawAOJe0AL8fNQXu/mkyha1RXoorXD8=";
  };
  ktfmt = downloadPlugin {
    name = "ktfmt";
    version = "1.2.0.53";
    url = "https://downloads.marketplace.jetbrains.com/files/14912/626875/ktfmt_idea_plugin-1.2.0.53.zip";
    hash = "sha256-9dGFZkrovtu7vawAOJe0AL8fNQXu/mkyha1RXoorXD8=";
  };
  copilot = downloadPlugin {
    name = "copilot";
    version = "1.5.28.7313";
    url = "https://downloads.marketplace.jetbrains.com/files/17718/625434/github-copilot-intellij-1.5.28.7313.zip";
    hash = "sha256-9dGFZkrovtu7vawAOJe0AL8fNQXu/mkyha1RXoorXD8=";
  };
  discord_integration = downloadPlugin {
    name = "dev.azn9.plugins.discord";
    version = "2.1.3.242";
    url = "https://downloads.marketplace.jetbrains.com/files/23420/589466/JetBrains-Discord-Integration-2.1.3.242.zip";
    hash = "sha256-IAej9Hqyk3M/BSSj9URC0Q1D5XaVirmbmP8Hj1RYMKU=";
  };
in
{
  home.packages = with pkgs; [
    (jetbrains.plugins.addPlugins jetbrains.idea-ultimate [
      detekt
      ktfmt
      copilot
      discord_integration
    ])
  ];
}
