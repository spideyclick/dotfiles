{ pkgs, ...}: {
  targets.genericLinux.enable = true;
  programs.git = {
    enable = true;
    userName  = "spideyclick";
    userEmail = "spideyclick@gmail.com";
  };
}

