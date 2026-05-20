-- Mappings are defined manually in /after/ftplugin/tex.lua
-- so that we can get descriptions.
vim.g.vimtex_mappings_enabled = 0

vim.g.vimtex_view_enabled = 1
-- TODO: Add guard to check for platform
vim.g.vimtex_view_method = 'skim'
--[[
======== Skim Settings =========
For automatic refresh on successful compilation:
|- Check for file Changes: on
|- Reload automatically: on

For inverse search:
|- PDF-TeX Sync Support
	 |- Preset: Custom
	 |- Command: nvim
	 |- Arguments: --headless -c "VimtexInverseSearch %line '%file'"
--]]

vim.notify('VimTex settings set.')

--[[
see vimtex_quickfix_open_on_warning and vimtex_quickfix_ignore_filters for better filter options.

Explore the following from https://ejmastnak.com/tutorials/vim-latex/pdf-reader/#refocus-nvim-macos-inverse
function! s:TexFocusVim() abort
  " Replace `TERMINAL` with the name of your terminal application
  " Example: execute "!open -a iTerm"  
  " Example: execute "!open -a Alacritty"
  silent execute "!open -a TERMINAL"
  redraw!
endfunction

augroup vimtex_event_focus
  au!
  au User VimtexEventViewReverse call s:TexFocusVim()
augroup END
--]]
