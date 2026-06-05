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

local in_math_env = function()
	return vim.fn['vimtex#syntax#in_mathzone']() == 1
end


return {

	s(
		{
			trig='log',
			desc='LaTeX log math function.',
			snippetType='autosnippet',
			condition = in_math_env
		},

		fmta(
			'\\log_{<>} \\left( <> \\right)',
			{
				i(1),
				i(2),
			}
		)
	),

	s(
		{
			trig='ln',
			desc='LaTeX ln math function.',
			snippetType='autosnippet',
			condition = in_math_env
		},

		fmta(
			'\\ln \\left( <> \\right)',
			{
				i(1),
			}
		)
	),


	s(
		{
			trig='frac',
			desc='LaTeX frac math function.',
			snippetType='autosnippet',
			condition = in_math_env
		},

		fmta(
			'\\frac{<>}{<>}',
			{
				i(1),
				i(2),
			}
		)
	),

	s(
		{
			trig='([^%s])pow',
			desc='LaTeX pow math function.',
			wordTrig = false,
			regTrig = true,
			snippetType='autosnippet',
			condition = in_math_env
		},

		fmta(
			'<>^{<>}',
			{
				f( function(_, snip) return snip.captures[1] end),
				i(1),
			}
		)
	),

}
