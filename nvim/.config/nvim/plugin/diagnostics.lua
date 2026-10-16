-- =============================================================================
-- Diagnostics =================================================================
-- =============================================================================

vim.diagnostic.config({
  virtual_text = {
    prefix = '●',  -- You can use '■', '●', '▎', etc.
    spacing = 2,
  },
  signs = true,
  underline = true,
  update_in_insert = false, -- Optional: disables updates while in insert mode
  severity_sort = true,
})
