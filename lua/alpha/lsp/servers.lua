local lsp_attach = require("alpha.lsp.attach")

local lsp_flags = {
  debounce_text_changes = 150,
}

local default = function()
  return {
    on_attach = lsp_attach,
    flags = lsp_flags,
  }
end

return {
  ["html"] = default,
  ["jsonls"] = default,
  ["lua_ls"] = function()
    return {
      on_attach = lsp_attach,
      flags = lsp_flags,
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
          hint = {
            enable = true,
          }
        },
      },
    }
  end,
  ["phpactor"] = function()
    return {
      on_attach = lsp_attach,
      flags = lsp_flags,
      filetypes = { "php", "cucumber" },
    }
  end,
}
