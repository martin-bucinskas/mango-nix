-- Mason Setup
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    }
})
require("mason-lspconfig").setup()

vim.cmd([[:MasonInstall rust-analyzer codelldb]])