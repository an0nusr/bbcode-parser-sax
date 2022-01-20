# bbcode-parser-sax - a bbcode parser with no dependencies and a simple API.

bbcode-parser-sax is a bbcode parser, writen with PEGjs. The PEGjs grammar is
compiled into a parser library and does not have any dependencies.

The parser outputs a list of events in json, each with a specified type,
similar to a SAX parser.

For example, given the string: `The quick brown fox [i]jumped[/i]
 [b]over[/b] the [u]stream[/u]`, the tool would emit:

 ```js
 [
  { type: 'text', text: 'The quick brown ' },
  { type: 'startTag', tag: { name: 'i', value: null } },
  { type: 'text', text: 'fox' },
  { type: 'endTag', tag: { name: 'i', value: null } },
  { type: 'text', text: ' ' },
  { type: 'startTag', tag: { name: 'b', value: null } },
  { type: 'text', text: 'jumped' },
  { type: 'endTag', tag: { name: 'b', value: null } }
]
```

Tags that have values, like `[url=https://site.com]` will be parsed
as `tag: { name: 'url', value: 'https://site.com' }`.

This style allows the parser to be simple, and makes it easy to adapt
the output to whatever you'd like!

## Building
Run `yarn build` from the project directory to both generate the parser
from the grammar, and to build cjs and esm outputs. 

## Usage
Usage will depend if you're using this with CommonJS or ESM

For CommonJS:
```js
const {parse} = require("bbcode-parser-sax")
return parse(BBCODE_STRING)
```

For ESM:
```js
import parser from 'bbcode-parser-sax'
return parser.parse(BBCODE_STRING)
```

## Tests
This package has a few basic tests to confirm the parser is working.
Run `yarn test` to execute the tests. 