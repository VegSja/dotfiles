local null_ls = require "null-ls"

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {
  -- Formatting 
  formatting.prettier,
  formatting.stylua,
  formatting.rustfmt,

  lint.eslint,

   -- Linting 
   lint.shellcheck,
}

null_ls.setup {
   debug = true,
   sources = sources,
}
