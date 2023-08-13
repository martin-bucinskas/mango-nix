{ pkgs, ... }: {
    home.packages = with pkgs; [
        rustup
        exa
        fd
        ripgrep
    ];

    programs.rustup = {
        enable = true;
        toolchains.stable.components = [ "rust-src" "rustfmt" "clippy" ];
    };
}