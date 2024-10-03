{
  user,
  lib,
  config,
  pkgs,
  ...
}:
{

  options = {
    vt.firefox.enable = lib.mkEnableOption "Enable firefox";
  };

  config = {
    programs.firefox = lib.mkIf config.vt.firefox.enable {
      enable = true;
      profiles.${user} = {
        userChrome = builtins.readFile ./userChrome.css;
        extraConfig = builtins.readFile ./user.js;

        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          # Privacy
          ublock-origin
          clearurls
          facebook-container
          multi-account-containers
          addy_io
          decentraleyes

          # Essential
          darkreader
          sponsorblock
          firefox-color
          onepassword-password-manager
        ];

        search = {
          force = true;
          default = "DuckDuckGo";
          engines = {
            "My nixOS" = {
              urls = [
                {
                  template = "https://mynixos.com/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@mn" ];
            };
          };
        };
        settings = {
          "browser.startup.homepage" = "about:home";
          "browser.uitour.enabled" = false;
          "trailhead.firstrun.didSeeAboutWelcome" = true;
          "browser.bookmarks.restore_default_bookmarks" = false;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

          # Disable some telemetry
          "app.shield.optoutstudies.enabled" = false;
          "browser.discovery.enabled" = false;
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.ping-centre.telemetry" = false;
          "datareporting.healthreport.service.enabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.sessions.current.clean" = true;
          "devtools.onboarding.telemetry.logged" = false;
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.hybridContent.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.prompted" = 2;
          "toolkit.telemetry.rejected" = true;
          "toolkit.telemetry.reportingpolicy.firstRun" = false;
          "toolkit.telemetry.server" = "";
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.unifiedIsOptIn" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          # Disable fx accounts
          "identity.fxaccounts.enabled" = false;
          # Disable "save password" prompt
          "signon.rememberSignons" = false;
          # Harden
          "privacy.trackingprotection.enabled" = true;
          "dom.security.https_only_mode" = true;
        };
      };
    };
  };
}
