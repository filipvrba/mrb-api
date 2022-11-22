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
		event_p(get_time(), get_ip_origin(a), json_struct.code, json_struct.mrb_code)

		return a.json(json_struct)
	}
	else {
		json_err_struct := ResultError { warning, war_helper_mess }
		event_p(get_time(), get_ip_origin(a), json_err_struct.code, json_err_struct.message)

		return a.json(json_err_struct)
	}
}
