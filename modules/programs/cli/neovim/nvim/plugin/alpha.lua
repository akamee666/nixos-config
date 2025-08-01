local alpha = require('alpha')

local dashboard = require('alpha.themes.dashboard')

dashboard.section.buttons.val = {
  dashboard.button("ff", " " .. " > find file",    "<cmd>lua require('fzf-lua').files()<cr>"),
  dashboard.button("fg", " " .. " > find word",    "<cmd>lua require('fzf-lua').live_grep()<cr>"),
  dashboard.button("fr", " " .. " > recents",      "<cmd>lua require('fzf-lua').oldfiles()<cr>"),
  dashboard.button("n", " " .. " > new file",     "<cmd>ene<cr>"),
  dashboard.button("c", " " .. " > config",       function()
    require("fzf-lua").files({ cwd = "/etc/nixos" })
  end),
  dashboard.button("q", " " .. " > quit",         "<cmd>qa<cr>"),
}

alpha.setup(dashboard.opts)
