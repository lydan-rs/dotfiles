-- ------------------------------------------------------------------------------
-- Imports ----------------------------------------------------------------------
-- ------------------------------------------------------------------------------

local ls   = require('luasnip')
local s    = ls.snippet
local t    = ls.text_node


-- ------------------------------------------------------------------------------
-- Module Begin -----------------------------------------------------------------
-- ------------------------------------------------------------------------------

local M = {}

-- General Context --------------------------------------------------------------

M.context = {}

M.context.at_line_begin = require('luasnip.extras.expand_conditions').line_begin

-- LaTeX Contet -----------------------------------------------------------------

M.context.latex = {}

M.context.latex.in_math_env = function()
	return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

-- Generators -------------------------------------------------------------------

M.generators = {}

---Simple trigger to text alias node.
---@param trigger string
---@param text string
---@param description string
---@param condition function|nil Function returns boolean. nil if no condition.
---@return LuaSnip.Snippet
M.generators.alias = function (trigger, text, description, condition)
	local opts = {
		trig = trigger,
		desc = description,
		snippetType='autosnippet',
	}
	if condition ~= nil then
		opts.condition = condition
	end

	return s(opts, {t(text)})
end

-- Return -----------------------------------------------------------------------

return M
