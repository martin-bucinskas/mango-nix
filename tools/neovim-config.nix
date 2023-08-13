{ pkgs ? import <nixpkgs> {}, lib, ... }: 
let
    myVimPlugins = with pkgs.vimPlugins; [
        "vim-airline"
        "williamboman/mason.nvim"
        "williamboman/mason-lspconfig.nvim"
    ];

    myVimPackages = map (plugin: { plugin = plugin; }) myVimPlugins;
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