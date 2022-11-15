module main

import vweb

struct Result {
	code_head string
	value string
}

['/'; get]
fn (mut a App) page_root() vweb.Result {
	code_head := a.query['code']
	json_struct := Result{ code_head, mrb_code(code_head) }
	println(json_struct)

	return a.json(json_struct)
}