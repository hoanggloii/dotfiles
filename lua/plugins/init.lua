return {
	{
		"stevearc/conform.nvim",
		-- event = 'BufWritePre' -- uncomment for format on save
		enabled = true,
		config = function()
			require("configs.conform")
		end,
	},
	{
		"simrat39/rust-tools.nvim",
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("nvchad.configs.lspconfig").defaults()
			require("configs.lspconfig")
		end,
	},

	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"lua-language-server",
				"stylua",
				"prettier",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"vim",
				"lua",
			},
		},
	},
	{
		"kyazdani42/nvim-tree.lua",
		lazy = true,
		event = "BufRead",
		cmd = { "NvimTree", "NvimTreeToggle", "NvimTreeFocus", "NvimTreeClose" },
		dependencies = "kyazdani42/nvim-web-devicons",
		config = function()
			require("configs.user.nvimtree")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = { "BufRead", "BufNewFile", "InsertEnter" },
		config = function()
			require("configs.user.lualine")
		end,
	},
	{
		"jayp0521/mason-null-ls.nvim",
		lazy = true,
		dependencies = {
			"nvimtools/none-ls.nvim",
			dependencies = {
				"nvimtools/none-ls-extras.nvim",
				lazy = true,
			},
			config = function()
				require("configs.user.null_ls")
			end,
		},
		event = "InsertEnter",
		opts = function()
			require("configs.user.mason-null-ls")
		end,
	},
	{
		"mrjones2014/smart-splits.nvim",
		event = "BufRead",
		config = function()
			require("configs.user.smartsplit")
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "BufRead",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		cmd = "ToggleTerm",
		event = "BufRead",
		config = function()
			require("configs.user.toggleterm")
		end,
	},
	{
		"nvim-lua/plenary.nvim",
	},
	{
		"mfussenegger/nvim-dap",
	},
	{
		"rust-lang/rust.vim",
	},
	{
		"darrikonn/vim-gofmt",
	},
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
}
