{
    description = "Mango-NIX development environment for WSL 2 Ubuntu";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        utils.url = "github:numtide/flake-utils";
        devenv.url = "github:cachix/devenv";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs"; 
        };
        mason-nvim.url = "github:williamboman/mason.nvim";
        mason-lspconfig-nvim.url = "github:williamboman/mason-lspconfig.nvim";
    };

    outputs = {
        nixpkgs,
        home-manager,
        utils,
        devenv,
        mason-nvim,
        mason-lspconfig-nvim,
        ...
    }: let
        user = "martini";
        config = {
            allowUnfree = true;
        };
    in {
        homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs {
                inherit config;
                system = "x86_64-linux";
            };

            modules = [
                ./tools
            ];
        };
    };
}