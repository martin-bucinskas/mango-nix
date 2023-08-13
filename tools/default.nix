{ config, lib, pkgs, mason-nvim, mason-lspconfig-nvim, ... }: {
    imports = [
        ./neovim-config.nix
        ./home-manager.nix
        ./git.nix
        ./bash.nix
        ./languages
    ];
}