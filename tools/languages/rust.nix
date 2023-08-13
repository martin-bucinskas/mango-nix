{ pkgs, ... }: {
    home.packages = with pkgs; [
        rustc
        cargo
        rustfmt
        rust-analyzer
        llvmPackages_14.lldb
        gdb
    ];
}