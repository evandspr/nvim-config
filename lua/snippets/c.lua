local ls = require 'luasnip'

local snippet = ls.snippet
local insert_node = ls.insert_node
local text_node = ls.text_node
local fmt = require('luasnip.extras.fmt').fmt

print 'Loading C snippets'
return {
  snippet(
    { trig = 'main', desc = 'Main function' },
    fmt(
      [[
        int main(int argc, char **argv) {{
          {}
          return (0);
        }}
      ]],
      {
        insert_node(0),
      }
    )
  ),
}
