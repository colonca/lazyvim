local lsp_attach = require("alpha.lsp.attach")
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
local util = require("lspconfig/util")

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
  ["csharp_ls"] = function()
    return {
      on_attach = lsp_attach,
      capabilities = capabilities,
      root_dir = function(startpath)
        return util.root_pattern("*.sln")(startpath)
          or util.root_pattern("*.csproj")(startpath)
          or util.root_pattern("*.fsproj")(startpath)
          or util.root_pattern(".git")(startpath)
      end,
    }
  end,
  ["rust_analyzer"] = function()
    return {
      on_attach = lsp_attach,
      capabilities = capabilities,
      filetypes = { "rust" },
      root_dir = util.root_pattern("cargo.toml"),
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
          },
        },
      },
    }
  end,
  ["emmet_ls"] = function()
    return {
      on_attach = lsp_attach,
      flags = lsp_flags,
      capabilities = capabilities,
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "blade", "vue" },
    }
  end,
  ["html"] = default,
  ["tailwindcss"] = default,
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
          },
        },
      },
    }
  end,
  ["tsserver"] = function()
    return {
      on_attach = lsp_attach,
      flags = lsp_flags,
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
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
