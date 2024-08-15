return {
	"Civitasv/cmake-tools.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"akinsho/toggleterm.nvim",
	},
	opts = {
		cmake_build_directory = "build",
		cmake_generate_options = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" },
		cmake_runner = { -- runner to use
			name = "toggleterm", -- name of the runner
			opts = {}, -- the options the runner will get, possible values depend on the runner type. See `default_opts` for possible values.
			default_opts = { -- a list of default and possible values for runners
				quickfix = {
					show = "always", -- "always", "only_on_error"
					position = "top", -- "bottom", "top"
					size = 10,
					encoding = "utf-8",
					auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
				},
				toggleterm = {
					direction = "horizontal", -- 'vertical' | 'horizontal' | 'tab' | 'float'
					close_on_exit = false, -- whether close the terminal when exit
					auto_scroll = true, -- whether auto scroll to the bottom
					singleton = true, -- single instance, autocloses the opened one, if present
				},
			},
		},
	},
}
