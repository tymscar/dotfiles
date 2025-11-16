{ ... }:

{
  programs.git = {
    enable = true;
    lfs = {
      enable = true;
    };
    ignores = [ ".DS_Store" ];
    signing = {
      key = "F5350C5A";
      signByDefault = true;
    };
    settings = {
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
