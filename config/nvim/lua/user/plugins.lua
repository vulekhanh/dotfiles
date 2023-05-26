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
	"folke/which-key.nvim",
	"folke/neodev.nvim",
	{ "catppuccin/nvim", name = "catppuccin" },

	-- Icons
	"nvim-tree/nvim-web-devicons",

	--Status line
	{
	  'nvim-lualine/lualine.nvim',
	  requires = { 'nvim-tree/nvim-web-devicons', opt = true }
 	},

	-- Neovim dashboard
	{
	   'goolord/alpha-nvim',
	    config = function ()
		    require'alpha'.setup(require'alpha.themes.dashboard'.config)
	    end
	}
})
