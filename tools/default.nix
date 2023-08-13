{ config, lib, pkgs, ... }: {
    imports = [
        ./nixvim-config.nix
        ./home-manager.nix
        ./git.nix
        ./bash.nix
        ./languages
    ];

    home.packages = with pkgs; [
        gcc
        gnumake
        binutils
        zip
        unzip
        exa
        fd
        ripgrep
    ];
}