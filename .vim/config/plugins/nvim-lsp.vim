lua << EOF
local nvim_lsp = require 'nvim_lsp'
nvim_lsp.ccls.setup{
    cmd = {
        'ccls',
        '--init={"clang": {"extraArgs": ["-isystem/Library/Developer/CommandLineTools/usr/include/c++/v1 -isysroot/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk"]}}'
    };
}
EOF
