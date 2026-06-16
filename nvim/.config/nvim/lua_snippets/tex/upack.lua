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


local show_if_text = function(args, parent, user_args)
	-- vim.notify('Hello From Function Node.')
	-- vim.notify(args[1][1])
	-- vim.notify('to_show: ' .. user_args)
	if args[1][1] == '' then
		return ''
	else
		return user_args
	end
end

local optionals = function (pos)
	return sn(
		pos,
		{
			f(show_if_text, {1}, {user_args={'['}}),
			i(1, '...', {
				node_callbacks = {
					[ls_events.leave] = function(node)
						local text = node:get_text()
						if #text == 1 and text[1] == '...' then
							node:set_text({''})
						end
					end
				}
			}),
			f(show_if_text, {1}, {user_args={']'}}),
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
				optionals(2),
				i(1),
			}
		)
	),

	s(
		{
			trig='Upack',
			desc='Adds a usepackage call.',
			snippetType='autosnippet',
			condition=at_line_begin,
		},
		fmta(
			'\\usepackage<><><>{<>}',
			{
				f(show_if_text, {2}, {user_args={'['}}),
				i(2, '...', {
					node_callbacks = {
						[ls_events.leave] = function(node)
							local text = node:get_text()
							if #text == 1 and text[1] == '...' then
								node:set_text({''})
							end
						end
					}
				}),
				f(show_if_text, {2}, {user_args={']'}}),
				i(1),
			}
		)
	),

}
