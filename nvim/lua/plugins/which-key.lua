return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 0
	end,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		timeoutlen = 0,
	},
	config = function()
		local whichkey = require("which-key")
    local session = require("auto-session.session-lens")

		local opts = {
			mode = "n", -- NORMAL mode
			prefix = "<leader>",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = true, -- use `nowait` when creating keymaps
		}

    local visual_opts = {
        mode = "v", -- VISUAL mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
    }


		local mappings = {
			["w"] = { "", "Windows" },
			["ws"] = { "<cmd>split<CR>", "Horizontal Split" },
			["wv"] = { "<cmd>vsplit<CR>", "Vertical Split" },
			["wq"] = { "<cmd>q<CR>", "Close buffer" },

      ["b"] = {"", "Buffers"},
      ["bf"] = {":Neotree buffers reveal float<CR>", "Search Buffers"},

			["o"] = { "", "Open" },
			["ot"] = { "<cmd>ToggleTerm<CR>", "Open Terminal" },
			["on"] = { ":Neotree filesystem toggle left<CR>", "Open filetree" },
      ["of"] = { "<CMD>Oil<CR>", "Open FileExplorer" },

      ["g"] = {"", "Git"},
      ["gg"] = {"<cmd>LazyGit<CR>", "Open LazyGit"},



      ["c"] = {"", "Code"},
			["ca"] = { vim.lsp.buf.code_action, "Code Action" },
			["cf"] = { vim.lsp.buf.definition, "Format file" },
			["cd"] = { vim.lsp.buf.definition, "Go to Definition" },
			["cr"] = { vim.lsp.buf.references, "Find References" },
			["ch"] = { vim.lsp.buf.hover, "Show Hover" },

			["f"] = { "", "Find" },
			["ff"] = { "<cmd>lua require('telescope.builtin').find_files()<CR>", "Find Files" },
			["fg"] = { "<cmd>lua require('telescope.builtin').live_grep()<CR>", "Live Grep" },
			["fp"] = { "<cmd>Telescope projects<CR>", "Telescope Projects" },
      ["fs"] = { session.search_session, "Find Session"},
      ["fh"] = { "<cmd>Telescope help_tags<CR>", "Telescope Help" },

      ["l"] = { "", "Latex" },
      ["lc"] = { "<Plug>(vimtex-compile)", "Compile LaTeX" },
      ["lv"] = { "<Plug>(vimtex-view)", "View PDF" },
      ["lt"] = { "<Plug>(vimtex-tex-compile)", "Run LaTeX" },
      ["ll"] = { "<Plug>(vimtex-tex-compile-pdf)", "Run PDFLaTeX" },
      ["lb"] = { "<Plug>(vimtex-bibtex)", "Run BibTeX" },
      ["li"] = { "<Plug>(vimtex-makeindex)", "Run MakeIndex" },
      ["lo"] = { "<Plug>(vimtex-compile-selected)", "Open PDF" },

      ["m"] = {"", "Markdown"},
      ["mp"] = { "<cmd>MarkdownPreviewToggle<CR>", "Markdown Preview" },

      ["y"] = { '"+y', "Yank to system clipboard"},
      ["p"] = { '"+p', "Paste from system clipboard"}
		}

		whichkey.register(mappings, opts)
		whichkey.register(mappings, visual_opts)
	end,
}
