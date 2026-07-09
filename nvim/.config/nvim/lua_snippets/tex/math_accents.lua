local ls   = require('luasnip')
local s    = ls.snippet
local sn   = ls.snippet_node
local t    = ls.text_node
local i    = ls.insert_node
local f    = ls.function_node
local d    = ls.dynamic_node
local r    = require('luasnip.extras').rep
local fmta = require('luasnip.extras.fmt').fmta

local in_math_env = require('snippet_utils').context.latex.in_math_env

return {

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
			'<>^{ <> }',
			{
				f( function(_, snip) return snip.captures[1] end),
				i(1),
			}
		)
	),

	s(
		{
			trig='([^%s])deg',
			desc='Denote value as degrees.',
			wordTrig = false,
			regTrig = true,
			snippetType='autosnippet',
			condition = in_math_env
		},

		fmta(
			'<>^{\\circ}',
			{
				f( function(_, snip) return snip.captures[1] end),
			}
		)
	),

	s(
		{
			trig='([^%s])comp',
			desc='Set compliment.',
			wordTrig = false,
			regTrig = true,
			snippetType='autosnippet',
			condition = in_math_env
		},

		fmta(
			'<>^{\\mathsf{c}}',
			{
				f( function(_, snip) return snip.captures[1] end),
			}
		)
	),

}
