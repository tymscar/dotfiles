{ ... }:

{
  programs.git = {
    enable = true;
    ignores = [ ".DS_Store" ];
    userEmail = "oscar@tymscar.com";
    userName = "Oscar Molnar";
    delta.enable = true;
  };
}
