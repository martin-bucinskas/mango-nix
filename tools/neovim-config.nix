{ pkgs ? import <nixpkgs> {}, lib, ... }: 
let
    myVimPackages = with pkgs.vimPlugins; [
        "vim-airline"
        "williamboman/mason.nvim"
        "williamboman/mason-lspconfig.nvim"
    ];

    home.file.".config/nvim/init.lua" = {
        source = ./neovim/init.lua;
        mode = "0644";
    };
in {
    programs.neovim = {
        enable = true;
        
        packages.myVimPackages = {
            start = myVimPackages;
        };
    };
}