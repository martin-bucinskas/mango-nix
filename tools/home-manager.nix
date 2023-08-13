{ pkgs, ... }: {
    home.stateVersion = "23.05";
    home.username = "martini";
    home.homeDirectory = "/home/martini";
    programs.home-manager.enable = true;

    home.sessionVariables = {
        BASH_ENV = "${pkgs.bash}/etc/profile.d/alias-vim-to-nvim.sh";
    };

    environment.etc."profile.d/alias-vim-to-nvim.sh".text = ''
        alias vim='nvim'
    '';
}