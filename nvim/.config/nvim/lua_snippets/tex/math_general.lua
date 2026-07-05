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

local in_math_env = require('snippet_utils').context.latex.in_mat_env

return {


	s(
		{
			trig='sin',
			desc='LaTeX sin math function.',
			snippetType='autosnippet',
			condition = in_math_env
		},

		fmta(
			'\\sin \\left( <> \\right)',
			{
				i(1),
			}
		)
	),

	s(
		{
			trig='cos',
			desc='LaTeX cos math function.',
			snippetType='autosnippet',
			condition = in_math_env
		},

		fmta(
			'\\cos \\left( <> \\right)',
			{
				i(1),
			}
		)
	),

	s(
		{
			trig='tan',
			desc='LaTeX tan math function.',
			snippetType='autosnippet',
			condition = in_math_env
		},

		fmta(
			'\\tan \\left( <> \\right)',
			{
				i(1),
			}
		)
	),


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
			trig='srt',
			desc='LaTeX square root.',
			snippetType='autosnippet',
			condition = in_math_env
		},

		fmta(
			'\\sqrt{<>}',
			{
				i(1),
			}
		)
	),

	s(
		{
			trig='root',
			desc='LaTeX n-root.',
			snippetType='autosnippet',
			condition = in_math_env
		},

		fmta(
			'\\sqrt[<>]{<>}',
			{
				i(1),
				i(2),
			}
		)
	),

}
