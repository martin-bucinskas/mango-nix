{ pkgs ? import <nixpkgs> {}, lib, ... }: 
let
    buildPlugin = owner: repo: pname: rev: sha256: pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = pname;
        version = "latest";
        src = pkgs.fetchFromGitHub { inherit owner repo rev sha256; };
    };

    myVimPlugins = with pkgs; [
        vimPlugins.vim-airline

        (buildPlugin "williamboman" "mason.nvim" "mason-nvim" "main" "sha256-HdwobGTecsVsrLpCrAJIE+tWUqFYF98/MxTNIfBIEDQ=")
        (buildPlugin "williamboman" "mason-lspconfig.nvim" "mason-lspconfig-nvim" "main" "sha256-QYN55F+WeUbHBKDddNuAVCBCFGXsZCD84Ugy5LMH+wI=")
        (buildPlugin "neovim" "nvim-lspconfig" "nvim-lspconfig" "master" "sha256-krHh6YI3svFimxv+U0oJZNHv4HguR/ljLLu0kMvPji0=")
        (buildPlugin "simrat39" "rust-tools.nvim" "rust-tools" "master" "sha256-jtfyDxifchznUupLSao6nmpVqaX1yO0xN+NhqS9fgxg=")
        (buildPlugin "hrsh7th" "nvim-cmp" "nvim-cmp" "main" "sha256-sdsfd+JxEEZI/JpCPW7v6wO0JuPzwBdbkPq0ajYgaYc=")
        (buildPlugin "hrsh7th" "cmp-nvim-lsp" "cmp-nvim-lsp" "main" "sha256-mU0soCz79erJXMMqD/FyrJZ0mu2n6fE0deymPzQlxts=")
        (buildPlugin "hrsh7th" "cmp-nvim-lua" "cmp-nvim-lua" "main" "sha256-6eXOK1mVK06TN1akhN42Bo4wQpeen3rk3b/m7iVmGKM=")
        (buildPlugin "hrsh7th" "cmp-nvim-lsp-signature-help" "cmp-nvim-lsp-signature-help" "main" "sha256-yDxYvjTIeXIKYR3tg+bf+okXKr5JYc/I9obP+6uKey4=")
        (buildPlugin "hrsh7th" "cmp-vsnip" "vsnip" "main" "sha256-2mkN03noOr5vBvRbSb35xZKorSH+8savQNZtgM9+QcM=")
        (buildPlugin "hrsh7th" "cmp-buffer" "cmp-buffer" "main" "sha256-dG4U7MtnXThoa/PD+qFtCt76MQ14V1wX8GMYcvxEnbM=")
        (buildPlugin "hrsh7th" "vim-vsnip" "vim-vsnip" "master" "sha256-ehPnvGle7YrECn76YlSY/2V7Zeq56JGlmZPlwgz2FdE=")
        (buildPlugin "nvim-treesitter" "nvim-treesitter" "nvim-treesitter" "master" "sha256-8+lF6ZIBRktyB/JHZRdbewkCCX71mmkcUf4fvtjiOJM=")
    ];

    myVimPlugs = map (plugin: { plugin = plugin; }) myVimPlugins;
in {
    programs.neovim = {
        enable = true;
        plugins = myVimPlugs;
    };

    home.file.".config/nvim/init.lua" = {
        text = builtins.readFile ./neovim/init.lua;
    };

    home.file.".config/nvim/lua/opts.lua" = {
        text = builtins.readFile ./neovim/opts.lua;
    };
}