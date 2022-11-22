module src

import time
import net.http

fn get_ip_origin(app App) string {
	return app.Context.req.header.get(http.CommonHeader.origin) or {
		app.Context.req.header.get(http.CommonHeader.host) or {""}
	}
}

fn get_time() string {
	return time.now().get_fmt_time_str(time.FormatTime.hhmmss12)
}

fn event_p(time_f string, ip_origin string, code string, value string) {
	println("$time_f [$ip_origin] $code $value")
}
