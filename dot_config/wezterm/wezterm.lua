
 return {
  color_scheme = 'Catppuccin Frappe',
	font = require("wezterm").font_with_fallback({
		"JetBrains Mono",
		{ family = "Symbols Nerd Font Mono", scale = 0.75 },
	}),
	window_background_opacity = 1.9,
	macos_window_background_blur = 10,
	force_reverse_video_cursor = true,
	window_decorations = "RESIZE",
	use_cap_height_to_scale_fallback_fonts = true,
	font_size = 16,
	scrollback_lines = 5000,
	hide_tab_bar_if_only_one_tab = true,
	window_close_confirmation = "NeverPrompt",
	window_padding = { left = 20, right = 5, top = 10, bottom = 0 },
	send_composed_key_when_left_alt_is_pressed = false,
	send_composed_key_when_right_alt_is_pressed = true,
	adjust_window_size_when_changing_font_size = false,
	warn_about_missing_glyphs = false,
}
