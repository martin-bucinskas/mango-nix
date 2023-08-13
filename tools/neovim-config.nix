{ pkgs, lib, ... }: {

    home.file.".config/nvim/init.lua" = {
        source = ./neovim/init.lua;
        mode = "0644";
    };

    programs.neovim = {
        enable = true;

        plugins = with pkgs.vimPlugins; [
            "vim-airline"
            "williamboman/mason.nvim"
            "williamboman/mason-lspconfig.nvim"
        ];
    };
}