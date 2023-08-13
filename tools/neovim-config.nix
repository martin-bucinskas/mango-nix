{ pkgs ? import <nixpkgs> {}, lib, ... }: 
let
    myVimPackages = with pkgs.vimPlugins; [
        "vim-airline"
        "williamboman/mason.nvim"
        "williamboman/mason-lspconfig.nvim"
    ];
in {
    programs.neovim = {
        enable = true;
        plugins = myVimPackages;
    };

    home.file.".config/nvim/init.lua" = {
        source = ./neovim/init.lua;
        mode = "0644";
    };
}