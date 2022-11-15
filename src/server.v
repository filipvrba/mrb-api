module main

import vweb

struct App {
    vweb.Context
}

fn main() {
	vweb.run_at(new_app(), vweb.RunParams{
        port: 8081
    }) or { panic(err) }
}

fn new_app() &App {
    mut app := &App{}
    return app
}

pub fn (mut a App) before_request() {
    a.add_header("Access-Control-Allow-Origin", "*")  
}
