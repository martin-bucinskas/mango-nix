{ pkgs ? import <nixpkgs> {}, lib, ... }: 
let
    buildPlugin = owner: repo: pname: rev: sha256: pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = pname;
        version = "latest";
        src = pkgs.fetchFromGitHub { inherit owner repo rev sha256; };
    };

    myVimPlugins = with pkgs; [
        vimPlugins.vim-airline
        vimPlugins.nvim-treesitter.withAllGrammars
        vimPlugins.nvim-gdb
        # 0000000000000000000000000000000000000000000000000000 - for sha256
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
        (buildPlugin "voldikss" "vim-floaterm" "vim-floaterm" "master" "sha256-wD4xfseEle2u0Zz8NGnU0mmstWAJqg5gPPxFQnqNw2k=")
        (buildPlugin "nvim-lua" "plenary.nvim" "plenary" "master" "sha256-oRtNcURQzrIRS3D88tWAl3HuFHxVJr8m/zzL7xoa/II=")
        (buildPlugin "nvim-telescope" "telescope.nvim" "telescope" "master" "sha256-BU6LFfuloNDhGSFS55sehZAX6mIqpD+R4X+sfu8aZwQ=")
        (buildPlugin "nvim-tree" "nvim-tree.lua" "nvim-tree-lua" "master" "sha256-w7JnGajbBQqmhrjeHZ9RMMYxhZQFOdsuaI0C8FEtTRM=")
        (buildPlugin "preservim" "tagbar" "tagbar" "master" "sha256-QQ79wURXG5ZlzaC+kC6ll8gn8ET4QWTVxxM1CXSbUVI=")
        (buildPlugin "folke" "todo-comments.nvim" "todo-comments" "main" "sha256-Qm8AJ8omU5eCfjLt91DVxLS0R3QHbfW55ZTegB1JvWI=")
        (buildPlugin "folke" "trouble.nvim" "trouble" "main" "sha256-Ee0AM8S/A8DU0hyOnZoKC1hkW0fvk0A+c3WGvPqmKcU=")
        (buildPlugin "ludovicchabant" "vim-gutentags" "vim-gutentags" "master" "sha256-gYBCzYzph6Fv7iL0XP+IvDR34VKINgnpKS7jZ6OC7UM=")
        (buildPlugin "nvim-tree" "nvim-web-devicons" "nvim-web-devicons" "master" "sha256-1qOM8ezmNAdLvhRwBe/yFKdjZep9zNto6NlKMF5vZps=")
        (buildPlugin "navarasu" "onedark.nvim" "onedark" "master" "sha256-et9NZeCkt39U/3bqzPP8OtSlRlSJyRbYZlv32978NLM=")
        # (buildPlugin "puremourning" "vimspector" "vimspector" "master" "sha256-ZT+bSs+KcEXeFQCvAd7niMPXNkPd32EgvhkuiESvzlU=")
        # (buildPlugin "mfussenegger" "nvim-dap" "nvim-dap" "master" "sha256-aXEgur2B3kLwioDRnkdtHOThWBplvD9RNcec55cwVPw=")
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

    home.file.".config/nvim/lua/keys.lua" = {
        text = builtins.readFile ./neovim/keys.lua;
    };
}