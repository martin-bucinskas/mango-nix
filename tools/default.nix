{ config, lib, pkgs, nixvim, ... }: {
    imports = [
        ./nixvim-config.nix
        ./home-manager.nix
        ./git.nix
        ./bash.nix
        ./neovim-config.nix
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