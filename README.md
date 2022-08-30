[![Building README.md](https://github.com/quirinux/readme/actions/workflows/build-readme.yml/badge.svg)](https://github.com/quirinux/readme/actions/workflows/build-readme.yml)
[![Building for Release](https://github.com/quirinux/readme/actions/workflows/release.yml/badge.svg)](https://github.com/quirinux/readme/actions/workflows/release.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/quirinux/readme)](https://hub.docker.com/r/quirinux/readme)
[![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/quirinux/readme/latest)](https://hub.docker.com/r/quirinux/readme)

# ReadME - a github readme builder
readme is a cli tool to extract markdown text from source code files

## Motivation
After trying some of doc builder tools I couldn't find anything that realy suits my needs, so decided to write my own

## Goals:
- be able to write doc block within source file
- having some useful vars to build the docs, like TODO tags
- build only one and huge readme indexed file

## Installation

TODO: Write installation instructions here

## Usage

```
readme 0.1.1
cli tool to extract markdown text from source code files

USAGE:
    readme [OPTIONS] [PATH]

ARGS:
    <PATH>    

OPTIONS:
    -f, --file-type <FILE_TYPE>    file types to filter by in a regex pattern
    -h, --help                     Print help information
    -n, --no-recursive             whether or not to look for files recursively
    -s, --show-context             prints context and exit
    -t, --template <TEMPLATE>      Handlebars template file
    -V, --version                  Print version information

```

## Development

TODO: Write development instructions here

### TODO
- [ ] having TODO/BUG/FIX dictionary would be nice to get it more feature rich
- [ ] needs to improve template error handling

## Contributing

1. Fork it (<https://github.com/quirinux/readme/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [QuirinuX](https://github.com/quirinux) - creator and maintainer


The following was generated using readme itself :-), check out how it is done on [README.md.j2](README.md.hbs).

---

## Table of Contents
1. [examples/rust.rs](#examples/rust.rs)
1. [examples/python.py](#examples/python.py)
1. [examples/ruby.rb](#examples/ruby.rb)

## examples/rust.rs
```
this is supposed to be a rust file with
some nice comments in it
```

## examples/python.py
```
this is supposed to be a python file with
some nice comments in it
```

## examples/ruby.rb
```
this is supposed to be a ruby file with
some nice comments in it
```



