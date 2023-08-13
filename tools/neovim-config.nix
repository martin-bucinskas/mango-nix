{ pkgs ? import <nixpkgs> {}, lib, mason-nvim, mason-lspconfig-nvim, ... }: 
let
    # fromGitHub = ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    #     pname = "${lib.strings.sanitizeDerivationName repo}";
    #     version = ref;
    #     src = builtins.fetchGit {
    #         url = "https://github.com/${repo}.git";
    #         ref = ref;
    #     };
    # };

    myVimPlugins = with pkgs.vimPlugins; [
        vim-airline
        (pkgs.vimUtils.buildVimPluginFrom2Nix {
            src = mason-nvim;
        })
        (pkgs.vimUtils.buildVimPluginFrom2Nix {
            src = mason-lspconfig-nvim;
        })
    ];

    myVimPackages = map (plugin: { plugin = plugin; }) myVimPlugins;
in {
    programs.neovim = {
        enable = true;
        plugins = myVimPackages;
    };

    home.file.".config/nvim/init.lua" = {
        text = builtins.readFile ./neovim/init.lua;
    };
}