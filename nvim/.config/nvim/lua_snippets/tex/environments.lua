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

local at_line_begin = require('luasnip.extras.expand_conditions').line_begin

return {

	s(
		{
			trig='env',
			desc='Creates a new environment block.',
			snippetType='autosnippet',
			condition=at_line_begin,
		},
		fmta(
			[[
			\begin{<>}
				<>
			\end{<>}
			]],
			{
				i(1),
				i(2),
				r(1),
			}
		)
	)

}
