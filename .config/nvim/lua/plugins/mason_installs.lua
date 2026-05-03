return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "deno",
        "python-lsp-server",
        "typescript-language-server",
        "html-lsp",
        "css-lsp",
      },
    },
  },
}
