return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "storm",
      on_highlights = function(hl, c)
        hl.DiagnosticUnnecessary = {
          undercurl = true,
          sp = c.comment,
        }
      end,
    },
  },
}
