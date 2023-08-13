{ pkgs, ... }: {
    home.sessionVariables = {
        BASH_ENV = "${pkgs.bash}/etc/profile.d/custom-aliases.sh";
    };

    environment.etc."profile.d/custom-aliases.sh".text = ''
        alias vim='nvim'
    '';
}