{ ... }:

{
  programs.git = {
    enable = true;
    ignores = [ ".DS_Store" ];
    signing = {
      key = "F5350C5A";
      signByDefault = true;
    };
    userEmail = "oscar@tymscar.com";
    userName = "Oscar Molnar";
    delta.enable = true;
  };
}
