{ pkgs, ... }: {
    home.packages = with pkgs; [
        rustc
        cargo
        rustfmt
        exa
        fd
        ripgrep
    ];
}