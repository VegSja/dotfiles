return {
  "rmagatti/auto-session",
  config = function()
    require("auto-session").setup({
      auto_session_supress_dirs = {"~/" , "~/Development", "~/Downloads", "/tmp", "/"},
      session_lens = {
        buftypes_to_ignore = {},
        load_on_setup = true,
        theme_conf = { border = true },
        previewer = false,
      },
    })
  end,
}
