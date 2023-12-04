local lsp_attach = require("alpha.lsp.attach")
local capabilities = require("alpha.lsp.servers").capabilities

local options = {
  on_attach = lsp_attach,
  capabilities = capabilities,
}

return options
