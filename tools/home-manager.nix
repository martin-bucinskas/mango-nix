{ pkgs, ... }: {
    home.stateVersion = "23.05";
    home.username = "martini";
    home.homeDirectory = "/home/martini";
    programs.home-manager.enable = true;
}