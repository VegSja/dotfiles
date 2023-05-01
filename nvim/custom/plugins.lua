local plugins = {
{
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults 
        "vim",
        "lua",

        -- web dev 
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        -- "vue", "svelte",

       -- low level
        "c",
        "zig"
      },
    },
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        -- Formatters
        "prettier",
        "stylua",
        "rustfmt",

        -- Linting
        "shellcheck",

        -- Debugging
        "debugpy",
        "codelldb"
      }
    },
    lazy = false
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        -- LSPs
        "pyright",
        "intelephense",
        "tailwindcss",
        "tsserver",
        "ltex",
        "jsonls",
        "kotlin_language_server",
        "rust_analyzer",
        "docker_compose_language_service",
        "lua_ls",
        "dockerls",
      },
    },
    lazy = false
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
         require "custom.configs.null-ls"
      end,
     },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
    lazy = false
  },
  {'kdheepak/lazygit.nvim',
    lazy=false
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function ()
      return require "custom.configs.rust-tools"
    end,
    config = function (_, opts)
      require('rust-tools').setup(opts)
    end
  },
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    event = "BufReadPre",
    dependencies = {
      "ravenxrz/DAPInstall.nvim",
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "nvim-telescope/telescope-dap.nvim",
    },
    config = function ()
      require "custom.configs.dap"
    end
  },
  { "nvim-lua/plenary.nvim" },
  { "tpope/vim-abolish" },
  { "nvim-pack/nvim-spectre"},
  {
    "tpope/vim-surround",
    lazy = false
  },
  { "tpope/vim-repeat",
    lazy = false
  },
  { "github/copilot.vim",
    lazy = false,
    init = function ()
      vim.api.nvim_set_keymap("i", "<C-\\>", "<Plug>(copilot-dismiss)", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>(copilot-next)", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>(copilot-previous)", { noremap = true, silent = true })
    end
  }
}
return plugins
