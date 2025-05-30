return {
  "codethread/qmk.nvim",
  enabled = false,
  config = function()
    ---@type qmk.UserConfig
    local conf = {
      name = "LAYOUT_preonic_grid",
      layout = {
        "_ x x x x x x x x x x x x x _ _ x _ _",
        "_ x _ x x x x x x x x x x x x _ x _ x",
        "_ x _ _ x x x x x x x x x x _ _ _ x x",
        "_ x _ _ _ x x x x x x x x x x _ x x x",
        "_ _ x x x _ _ _ x _ _ _ x x _ _ x x x",
      },
    }
    require("qmk").setup(conf)
  end,
}
