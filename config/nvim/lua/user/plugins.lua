local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-- Example using a list of specs with the default options
require("lazy").setup({

	-- Shortcuts
	"folke/which-key.nvim",
	"folke/neodev.nvim",
	-- Colorscheme
	{ "catppuccin/nvim", name = "catppuccin" },

	-- Icons
	"nvim-tree/nvim-web-devicons",

	--Status line
	{
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	},
	-- Bufferline
	{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },

	-- Neovim dashboard
	{
		"goolord/alpha-nvim",
		config = function()
			require("alpha").setup(require("alpha.themes.dashboard").config)
		end,
	},
	-- Nvimtree (File Explorer)
	{
		"nvim-tree/nvim-tree.lua",
		lazy = true,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},

	-- Telescope (Fuzzy Finder)
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
	},

	-- Syntax highlighting
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

	-- Indentation
	{ "lukas-reineke/indent-blankline.nvim" },

	-- Project management for neovim
	{ "ahmedkhalf/project.nvim" },

	-- Lsp
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "jose-elias-alvarez/null-ls.nvim" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "hrsh7th/cmp-buffer" }, -- Required
			{ "hrsh7th/cmp-path" }, -- Required
			{ "saadparwaiz1/cmp_luasnip" },
			-- Snippets
			{
				"L3MON4D3/LuaSnip",
				dependencies = { "rafamadriz/friendly-snippets" },
			},
		},
	},

	-- Autopairs
	{ "windwp/nvim-autopairs" },

	--Debug adapter protocol
	{ "mfussenegger/nvim-dap" },

	-- Git interation
	{ "lewis6991/gitsigns.nvim" },

	-- Comment
	{
		"numToStr/Comment.nvim",
	},
})
