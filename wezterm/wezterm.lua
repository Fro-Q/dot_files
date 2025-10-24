local wezterm = require "wezterm"

local config = {
  font_size = 28,
  color_scheme = "Gruvbox Dark (Gogh)",
  font = wezterm.font {
    family = "Monaspace Radon NF",
    weight = 200,
    harfbuzz_features = {
      "calt", "ss03", "ss04", "ss06", "ss07", "ss08", "ss09", "ss10", "liga",
    }
  },
  font_shaper = "Harfbuzz",
  front_end = "WebGpu",
  window_decorations = "RESIZE",
  hide_tab_bar_if_only_one_tab = true,


  window_frame = {
    font_size = 16.0,
  },

  default_cursor_style = "BlinkingBar",
  adjust_window_size_when_changing_font_size = false,
  use_fancy_tab_bar = false,
  show_new_tab_button_in_tab_bar = false,

  colors = {
    tab_bar = {
      background = "#888888",

      active_tab = {
        bg_color = "#000000",
        fg_color = "#F1F1F1",

        intensity = "Normal",

        underline = "None",

        italic = false,

        strikethrough = false,
      },

      inactive_tab = {
        bg_color = "#888888",
        fg_color = "#444444",

      },

      inactive_tab_hover = {
        bg_color = "#888888",
        fg_color = "#444444"

      },

      new_tab = {
        bg_color = "#888888",
        fg_color = "#444444",

      },

      new_tab_hover = {
        bg_color = "#888888",
        fg_color = "#1bfd9c",
      },
    },
  },
}

wezterm.on("user-var-changed", function(window, pane, name, value)
  local overrides = window:get_config_overrides() or {}
  if name == "ZEN_MODE" then
    local incremental = value:find("+")
    local number_value = tonumber(value)
    if incremental ~= nil then
      while (number_value > 0) do
        window:perform_action(wezterm.action.IncreaseFontSize, pane)
        number_value = number_value - 1
      end
      overrides.enable_tab_bar = false
    elseif number_value < 0 then
      window:perform_action(wezterm.action.ResetFontSize, pane)
      overrides.font_size = nil
      overrides.enable_tab_bar = true
    else
      overrides.font_size = number_value
      overrides.enable_tab_bar = false
    end
  end
  window:set_config_overrides(overrides)
end)

wezterm.on("update-status", function(window, _)
  local dimensions = window:get_dimensions()
  local is_full_screen = dimensions.is_full_screen

  if is_full_screen then
    window:set_config_overrides({
      window_padding = {
        left = "1cell",
        right = "1cell",
        top = "1.75cell",
        bottom = "0.5cell",
      }
    })
  else
    window:set_config_overrides({
      window_padding = {
        left = "1cell",
        right = "1cell",
        top = "0.5cell",
        bottom = "0.5cell",
      }
    })
  end
end)


return config
