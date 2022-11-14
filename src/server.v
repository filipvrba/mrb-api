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
