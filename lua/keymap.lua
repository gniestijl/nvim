-- Use which-key to create and document key mappings
local wk = require("which-key")

wk.register({
  f = {
    name = "file", -- optional group name
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    n = { "<cmd>enew<cr>", "New File" }
  },
}, { prefix = "<leader>" })

wk.register({
  b = { "<cmd>Telescope buffers<cr>", "Find buffer" },
}, { prefix = "<leader>" })

