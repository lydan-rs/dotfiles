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

local ls_events     = require('luasnip.util.events')
local at_line_begin = require('luasnip.extras.expand_conditions').line_begin



local optional = function (pos, placeholder)

	local show_if_input = function(args, _, user_args)
		if args[1][1] == '' or args[1][1] == placeholder then
			return ''
		else
			return user_args
		end
	end


	return sn(
		pos,
		{
			f(show_if_input, {1}, {user_args={'['}}),
			i(1, placeholder, {
				node_callbacks = {
					[ls_events.leave] = function(node)
						local text = node:get_text()
						if #text == 1 and text[1] == placeholder then
							node:set_text({''})
						end
					end
				}
			}),
			f(show_if_input, {1}, {user_args={']'}}),
		}
	)
end



return {

	s(
		{
			trig='upack',
			desc='Adds a usepackage call.',
			snippetType='autosnippet',
			condition=at_line_begin,
		},
		fmta(
			'\\usepackage<>{<>}',
			{
				optional(2, '>OPTS<'),
				i(1),
			}
		)
	),

}
