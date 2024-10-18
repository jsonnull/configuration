return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- IDE
	use("google/vim-searchindex") -- search index
	use("Yggdroot/indentLine") -- indent line
	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	-- edit
	use("tpope/vim-surround") -- toggle surround

	-- language
	use("rust-lang/rust.vim") -- rust language support
	use("LnL7/vim-nix") -- nix language support
	use("ckipp01/stylua-nvim") -- stylua formatter
end)
