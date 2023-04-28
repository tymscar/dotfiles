{ config, pkgs, ... }:

{
  programs.git.enable = true;

  programs.git.ignores = [
    ".DS_Store"
  ];

  programs.git.userEmail = "oscar@tymscar.com";
  programs.git.userName = "Oscar Molnar";

  programs.git.delta.enable = true;
}
