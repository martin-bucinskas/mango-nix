{ pkgs, ... }: {
    home.packages = with pkgs; [
        clang
        rustup
        llvmPackages_16.stdenv
        llvmPackages_16.libllvm
        universal-ctags
        gdb
    ];
}