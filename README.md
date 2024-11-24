# ExMaglev

[![Tests](https://github.com/Vonmo/ex_maglev/actions/workflows/elixir.yml/badge.svg?branch=develop)](https://github.com/Vonmo/ex_maglev/actions/workflows/elixir.yml)
[![Build precompiled NIFs](https://github.com/Vonmo/ex_maglev/actions/workflows/release.yml/badge.svg?branch=develop)](https://github.com/Vonmo/ex_maglev/actions/workflows/release.yml)
[![Validate precompiled NIFs](https://github.com/Vonmo/ex_maglev_test/actions/workflows/check.yml/badge.svg?branch=main)](https://github.com/Vonmo/ex_maglev_test/actions/workflows/check.yml)

## About

ExMaglev is NIF for Elixir which uses Rust binding for [Maglev](https://static.googleusercontent.com/media/research.google.com/en//pubs/archive/44824.pdf) - Google's consistent hashing algorithm.

## Installation
The package can be installed by adding `ex_maglev` to your list of dependencies in `mix.exs`:
```
def deps do
  [{:ex_maglev, "~> 0.1.0"}]
end
```

## Supported OS
* Linux
* Windows
* MacOS

## Main requirements for a driver
* Reliability
* Performance
* Minimal codebase
* Safety
* Functionality

## Performance
In a set of tests you can find a performance test and benchmarks

## Build Information
ExMaglev requires
* Erlang >= 24.
* Rust >= 1.76.
* Clang >= 15.


## Status
Passed all the functional and performance tests.

## License
ExMaglev's license is [Apache License Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html)
