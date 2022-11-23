module src

import vweb

const (
	port = 8080
)

struct App {
    vweb.Context
}

pub fn main() {
	vweb.run_at(new_app(), vweb.RunParams{
        port: port
    }) or { panic(err) }
}

fn new_app() &App {
    mut app := &App{}
    return app
}

pub fn (mut a App) before_request() {
    a.add_header("Access-Control-Allow-Origin", "*")  
}

pub fn (mut app App) health() vweb.Result {
	return app.json('{"statusCode":200, "status":"ok"}')
}
