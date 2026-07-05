local ls   = require('luasnip')
local s    = ls.snippet
local sn   = ls.snippet_node
local t    = ls.text_node
local i    = ls.insert_node
local f    = ls.function_node
local d    = ls.dynamic_node
local r    = require('luasnip.extras').rep
local fmt  = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta

local symbol = function (trigger, code, description)
	local in_math_env = require('snippet_utils').context.latex.in_mat_env
	local alias = require('snippet_utils').generators.alias
	return alias(trigger, code, description, in_math_env)
end

return {
-- General ----------------------------------------------------------------------

	symbol('times', '\\times', 'LaTeX multiply symbol.'),
	symbol('div'  , '\\div'  , 'LaTeX division symbol.'),

-- Sets and Logic ---------------------------------------------------------------

	symbol('AND', '\\vee'  , 'Prop-logic AND connective.'),
	symbol('OR' , '\\wedge', 'Prop-logic OR connective.'),
	symbol('NOT', '\\neg'  , 'Prop-logic NOT connective.'),
	symbol('IF' , '\\to'   , 'Prop-logic IF coniditional.'),

	symbol('ONLYIF', '\\leftrightarrow', 'Prop-logic IF AND ONLY IF coniditional.'),
	symbol('OIF'   , '\\leftrightarrow', 'Prop-logic IF AND ONLY IF bi-coniditional.'),

	symbol('IN'   , '\\in'      , 'Pred-logic in set symbol.'),
	symbol('NOTIN', '\\notin'   , 'Pred-logic not-in set symbol.'),
	symbol('ALL'  , '\\forall'  , 'Pred-logic universal (for all) quantifier.'),
	symbol('SOME' , '\\exists'  , 'Pred-logic existential (at-least one) quantifier.'),
	symbol('UNION', '\\cup'     , 'Set union symbol.'),
	symbol('ISECT', '\\cap'     , 'Set intersect symbol.'),
	symbol('EMPTY', '\\emptyset', 'Empty set symbol.'),


-- Trigonometry -----------------------------------------------------------------

	symbol('theta', '\\theta', 'LaTeX theta symbol.'),


}
