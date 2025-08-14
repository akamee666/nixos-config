-- Show buffers
require("bufferline").setup({
  options = {
    mode = "buffers",
    diagnostics = "nvim_lsp",
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = "slant",
    always_show_bufferline = true,
  },
})

-- always show tabline
vim.o.showtabline = 2
-- vim.o.hidden = true

-- Buffer list navigation
vim.keymap.set('n', 'bb', vim.cmd.bnext, { silent = true, desc = 'next [b]uffer' })
vim.keymap.set('n', 'bB', vim.cmd.bprevious, { silent = true, desc = 'previous [b]uffer' })
vim.keymap.set('n', 'b1', vim.cmd.bfirst, { silent = true, desc = 'first [B]uffer' })
-- vim.keymap.set('n', ']B', vim.cmd.blast, { silent = true, desc = 'last [B]uffer' })

