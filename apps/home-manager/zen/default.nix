{
  lib,
  pkgs,
  zen-browser,
  ...
}:
let
  extensions = {
    "{d634138d-c276-4fc8-924b-40a0ea21d284}" = "1password-x-password-manager";
    "adnauseam@rednoise.org" = "adnauseam";
    "hunch@tymscar.com" = "hunch";
    "{3c6bf0cc-3ae2-42fb-9993-0d33104fdcaf}" = "youtube-addon";
    "search@kagi.com" = "kagi-search-for-firefox";
    "sponsorBlocker@ajay.app" = "sponsorblock";
  };
in
{
  programs.zen-browser = {
    enable = true;
    darwin.packageMode = "signed";
    # Installed by copyZen below instead, so there is no mac-app-util trampoline
    package = null;

    policies.ExtensionSettings = builtins.mapAttrs (_: slug: {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/${slug}/latest.xpi";
      installation_mode = "force_installed";
    }) extensions;

    profiles.default = {
      id = 0;
      isDefault = true;
      path = "3f4dlpm3.Default (release)";

      mods = [];

      settings = {
        "zen.welcome-screen.seen" = true;
        "zen.workspaces.continue-where-left-off" = true;
        "zen.view.use-single-toolbar" = false;
        "zen.view.compact.enable-at-startup" = false;
        "zen.view.compact.hide-toolbar" = true;
        "zen.swipe.is-fast-swipe" = false;
        "browser.theme.toolbar-theme" = 0;
        "findbar.highlightAll" = true;

        # 1Password handles passwords
        "signon.rememberSignons" = false;
        "privacy.clearOnShutdown_v2.formdata" = true;
        "network.prefetch-next" = false;
        "network.http.speculative-parallel-limit" = 0;

        # Fullscreen fills the AeroSpace tile instead of reshuffling the layout
        "full-screen-api.ignore-widgets" = true;
        "full-screen-api.macos-native-full-screen" = false;
        "full-screen-api.transition-duration.enter" = "0 0";
        "full-screen-api.transition-duration.leave" = "0 0";
        "full-screen-api.transition.timeout" = 0;
        "full-screen-api.warning.timeout" = 0;
      };

      spaces = {
        "Space" = {
          id = "7ef33e93-76fc-4159-9c9e-5fc767d8f08b";
          position = 1000;
          icon = "🐧";
          pins = {
            "Dashy" = {
              id = "a73cd9f9-747b-48cb-9967-5bbdb77ffe7d";
              url = "https://dashy.tymscar.com/";
              position = 101;
            };
            "Proton Mail" = {
              id = "4927f247-8048-447a-ae1d-c75cbe0f3243";
              url = "https://mail.proton.me/u/1/inbox";
              position = 102;
            };
            "Messenger" = {
              id = "1e88ab00-5dce-423c-aac7-c5f3edd2ef58";
              url = "https://www.messenger.com/";
              position = 103;
            };
            "WhatsApp" = {
              id = "1aeb313a-b751-4c92-9962-196fe6ff899e";
              url = "https://web.whatsapp.com/";
              position = 104;
            };
            "Home Assistant" = {
              id = "24d733a7-c46e-4d33-82f0-efb7f090c3a3";
              url = "https://has.tymscar.com/lovelace/default_view";
              position = 106;
            };
          };
        };
        "Games" = {
          id = "bc24f379-ebc3-471a-9b82-3011121680b2";
          position = 2000;
          icon = "👾";
        };
      };
    };
  };

  # A real copy at a stable path, so the Dock pin and the running app are the same icon
  home.activation.copyZen = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run ${lib.getExe pkgs.rsync} --recursive --checksum --perms --links --copy-unsafe-links \
      --specials --delete --chmod=+w \
      "${zen-browser}/Applications/Zen Browser (Beta).app/" "$HOME/Applications/Zen.app"
  '';
}
