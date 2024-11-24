extern crate core;
extern crate libc;
extern crate rustler;
extern crate serde;
extern crate maglev;

mod atoms;
mod nif;

rustler::init!(
    "Elixir.ExMaglev",
    [
        nif::lxcode,
        nif::new,
        nif::get_capacity,
        nif::get_nodes,
        nif::hash,
    ],
    load = nif::on_load
);
