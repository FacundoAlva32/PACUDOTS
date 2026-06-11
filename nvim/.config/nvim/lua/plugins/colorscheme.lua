return {
  -- Configuración del Tema
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl, c)
        hl.Visual = { bg = "#4e5173" } -- Color de selección de texto
        hl.CursorLine = { bg = "#292e42" } -- ESTA ES LA LÍNEA que ves en image_caf339.png
      end,
    },
  }, -- Configuración de la barra de abajo
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "auto", -- O "auto" para que herede la transparencia
      },
    },
  },
}
