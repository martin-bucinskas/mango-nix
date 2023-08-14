{ config, lib, pkgs, nixvim, ... }: {
    imports = [
        ./home-manager.nix
        ./git.nix
        ./bash.nix
        ./neovim-config.nix
        ./languages
    ];

    home.packages = with pkgs; [
        # gcc
        gnumake
        # binutils
        zip
        unzip
        exa
        fd
        ripgrep
        tree-sitter
    ];
}