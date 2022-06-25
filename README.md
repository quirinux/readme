[![Building README.md](https://github.com/quirinux/readme/actions/workflows/build-readme.yml/badge.svg)](https://github.com/quirinux/readme/actions/workflows/build-readme.yml)
[![Building for Release](https://github.com/quirinux/readme/actions/workflows/release.yml/badge.svg)](https://github.com/quirinux/readme/actions/workflows/release.yml)

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
Usage: readme [arguments] [PATHS, dafault(current)]
    -t FILE, --template=FILE         Jinja2 template file, [default: default]
    --no-recursive                   Disable recursive file lookup, [default: false]
    --file-type=FILETYPE             File type extension to filter, [default: any]
    -v, --version                    Show version
    -h, --help                       Show this help
    --show-context                   Shows default context and template

For further help with templates please refer to: https://github.com/straight-shoota/crinja
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


The following was generated using readme itself :-), check out how it is done on [README.md.j2](README.md.j2).

---

## Table of Contents
1. [./examples/python.py](#examplespythonpy)
1. [./examples/ruby.rb](#examplesrubyrb)
1. [./examples/rust.rs](#examplesrustrs)
1. [./src/main.cr](#srcmaincr)
1. [./src/readme.cr](#srcreadmecr)

### [./examples/python.py](./examples/python.py)
this is supposed to be a python file with


some nice comments in it


### [./examples/ruby.rb](./examples/ruby.rb)
this is supposed to be a ruby file with


some nice comments in it


### [./examples/rust.rs](./examples/rust.rs)
this is supposed to be a rust file with


some nice comments in it


### [./src/main.cr](./src/main.cr)
this is the project main file, where all the magic begins
TODO: it'd be nice to have an exclude path/files flag


### [./src/readme.cr](./src/readme.cr)
readme file processor
this is the app file


