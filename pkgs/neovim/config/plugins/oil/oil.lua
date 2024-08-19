require("oil").setup({
	default_file_explorer = true,
	columns = {
		"icon",
	},
	keymaps = {
		["g?"] = "actions.show_help",
		["<CR>"] = "actions.select",
		["<C-p>"] = "actions.preview",
		["<C-c>"] = "actions.close",
		["<C-l>"] = "actions.refresh",
		["-"] = "actions.parent",
		["_"] = "actions.open_cwd",
		["gs"] = "actions.change_sort",
		["t"] = "actions.open_external",
		["."] = "actions.toggle_hidden",
		["g\\"] = "actions.toggle_trash",
	},
	preview_split = "left",
	filters = {
		dotfiles = false,
	},
})
