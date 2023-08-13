{ pkgs ? import <nixpkgs> {}, lib, ... }: 
let
    myVimPlugins = with pkgs; [
        vimPlugins.vim-airline
        (vimUtils.buildVimPluginFrom2Nix {
            pname = "packer";
            version = "latest";
            src = fetchFromGitHub {
                owner = "wbthomason";
                repo = "packer.nvim";
                rev = "master";
                sha256 = "sha256-YAhAFiR31aGl2SEsA/itP+KgkLyV58EJEwosdc+No9s=";
            };
        })
    ];

    myVimPlugs = map (plugin: { plugin = plugin; }) myVimPlugins;
in {
    programs.neovim = {
        enable = true;
        plugins = myVimPlugs;
    };

    home.file.".config/nvim/lua/plug.lua" = {
        text = builtins.readFile ./neovim/plug.lua;
    };

    home.file.".config/nvim/init.lua" = {
        text = builtins.readFile ./neovim/init.lua;
    };
}