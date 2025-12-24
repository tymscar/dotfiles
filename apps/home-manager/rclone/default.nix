{ ... }:

{
  programs.rclone = {
    enable = true;
    remotes = {
      b2 = {
        config = {
          type = "b2";
        };
        secrets = {
          account = "/run/agenix/b2-account";
          key = "/run/agenix/b2-key";
        };
      };
    };
  };
}
