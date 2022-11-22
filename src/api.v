module src

import vweb
import src.mruby

struct Result {
	code     string
	mrb_code string
	result   string
}

struct ResultError {
	code    string
	message string
}

['/'; get]
fn (mut a App) page_root() vweb.Result {
	mrb_head := a.query['mrb']
	
	if mrb_head.len != 0 {
		json_struct := Result{ result, mrb_head, mruby.mrb_code(mrb_head) }
		println(json_struct)

		return a.json(json_struct)
	}
	else {
		json_err_struct := ResultError { warning, war_helper_mess }
		return a.json(json_err_struct)
	}
}
