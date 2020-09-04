local nvim_lsp = require'nvim_lsp'
nvim_lsp.ccls.setup{
cmd ={
'ccls',
'--init = {"cache": {"directory": "/tmp/ccls-cache"}}'
},
filetypes = { "c", "cpp", "objc", "objcpp" },
root_dir = nvim_lsp.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
}
