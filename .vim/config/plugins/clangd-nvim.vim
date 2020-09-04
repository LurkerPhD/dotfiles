lua << EOF
require'nvim_lsp'.clangd.setup{
    capabilities = {
        textDocument = {
            semanticHighlightingCapabilities = {
                semanticHighlighting = true
            }
        }
    },
    on_init=require'clangd_nvim'.on_init
}
EOF
