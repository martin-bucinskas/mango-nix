{ config, lib, pkgs, ... }: {
    imports = [
        ./neovim-config.nix
        ./home-manager.nix
        ./git.nix
        ./bash.nix
        ./aliases.nix
    ];
}