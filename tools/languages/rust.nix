{ pkgs, ... }: {
    home.packages = with pkgs; [
        clang
        rustup
        llvmPackages_16.stdenv
        llvmPackages_16.libllvm
        # llvmPackages_16.bintools
        # llvmPackages_16.libcxxClang
        # rustfmt
        # rust-analyzer
        gdb
    ];

    # home.sessionVariables = {
    #     LIBCLANG_PATH = pkgs.lib.makeLibraryPath [ pkgs.llvmPackages_16.libclang.lib ];
    # };
}