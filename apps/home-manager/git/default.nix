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
    options = {
      dark = true;
      "line-numbers" = true;
      "minus-style" = "syntax #3f0001";
      "minus-emph-style" = "syntax #6f0000";
      "plus-style" = "syntax #003800";
      "plus-emph-style" = "syntax #005000";
      "zero-style" = "syntax";
    };
  };
}
