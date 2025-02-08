require('mason').setup()

require('mason-lspconfig').setup {
  ensure_installed = { 'tsserver', 'gopls' },
}

local lspconfig = require 'lspconfig'
lspconfig.tsserver.setup {}
