{ ... }:

{
  programs.git = {
    enable = true;
    lfs = {
      enable = true;
    };
    ignores = [ ".DS_Store" ];
    signing = {
      format = "openpgp";
      key = "F5350C5A";
      signByDefault = true;
    };
    settings = {
      pull = {
        rebase = true;
      };
      rebase = {
        autoStash = true;
      };
      user = {
        email = "oscar@tymscar.com";
        name = "Oscar Molnar";
      };
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
