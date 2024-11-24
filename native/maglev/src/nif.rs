use atoms::{error, ok, vsn1};

use rustler::resource::ResourceArc;
use rustler::types::atom::Atom;
use rustler::types::list::ListIterator;
use rustler::{Binary, Encoder, Env, NifResult, OwnedBinary, Term};
use std::sync::{Mutex, MutexGuard, RwLock, RwLockReadGuard, RwLockWriteGuard};
use maglev::{ConsistentHasher, Maglev};

// =================================================================================================
// resource
// =================================================================================================

#[repr(transparent)]
struct FilterResource(RwLock<Maglev<std::string::String>>);

impl FilterResource {
    fn read(&self) -> RwLockReadGuard<'_, Maglev<std::string::String>> {
        self.0.read().unwrap()
    }

    fn write(&self) -> RwLockWriteGuard<'_, Maglev<std::string::String>> {
        self.0.write().unwrap()
    }
}

impl From<Maglev<std::string::String>> for FilterResource {
    fn from(other: Maglev<std::string::String>) -> Self {
        FilterResource(RwLock::new(other))
    }
}

// ---------------------------------------------------------------------

pub fn on_load(env: Env, _load_info: Term) -> bool {
    rustler::resource!(FilterResource, env);
    true
}

// =================================================================================================
// api
// =================================================================================================

#[rustler::nif]
fn lxcode(env: Env) -> NifResult<Term> {
    Ok((ok(), vsn1()).encode(env))
}

#[rustler::nif]
fn new<'a>(env: Env<'a>, nodes: Vec<String>, capacity: usize) -> NifResult<Term<'a>> {
    let filt = Maglev::with_capacity(nodes, capacity);
    Ok((ok(), ResourceArc::new(FilterResource::from(filt))).encode(env))
}

#[rustler::nif]
fn get_capacity<'a>(env: Env<'a>, resource: ResourceArc<FilterResource>) -> NifResult<Term<'a>> {
    let filt_guard = resource.read();
    Ok((ok(), filt_guard.capacity()).encode(env))
}

#[rustler::nif]
fn get_nodes<'a>(env: Env<'a>, resource: ResourceArc<FilterResource>) -> NifResult<Term<'a>> {
    let filt_guard = resource.read();
    Ok((ok(), filt_guard.nodes()).encode(env))
}

#[rustler::nif]
fn hash<'a>(env: Env<'a>, resource: ResourceArc<FilterResource>, term: String) -> NifResult<Term<'a>> {
    let filt_guard = resource.read();
    Ok((ok(), filt_guard.get(term.as_str())).encode(env))
}
