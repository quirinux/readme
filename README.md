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

TODO: Write usage instructions here

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
1. [example/rust.rs](#examplerustrs)
1. [example/ruby.rb](#examplerubyrb)
1. [example/python.py](#examplepythonpy)
1. [src/readme.cr](#srcreadmecr)
1. [src/main.cr](#srcmaincr)

### [example/rust.rs](example/rust.rs)
this is supposed to be a rust file with


some nice comments in it


### [example/ruby.rb](example/ruby.rb)
this is supposed to be a ruby file with


some nice comments in it


### [example/python.py](example/python.py)
this is supposed to be a python file with


some nice comments in it


### [src/readme.cr](src/readme.cr)
readme file processor
this is the app file
- TODO: add pattern filter
- TODO: add file type filter
- TODO: add user passed path instead of listing current
- TODO: add no-recursive option


### [src/main.cr](src/main.cr)
this is the project main file, where all the magic begins
TODO: it'd be nice to have an exclude path/files flag


