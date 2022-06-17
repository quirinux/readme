# ReadME - a github readme builder
readme is a cli tool to extract markdown text from source code files

## Motivation
after trying some of doc builder tools I couldn't find anything that realy suits my needs, so decided to write my own

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
- [ ] having TODO/BUG/FIX dictionary would be nice to get more feature rich

## Contributing

1. Fork it (<https://github.com/quirinux/readme/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [QuirinuX](https://github.com/quirinux) - creator and maintainer

## From now on this was generated using readme self :-)



### (src/main.cr)[src/main.cr]
this is the project main file, where all the magic begins
TODO: it'd be nice to have an exclude path/files flag

### (src/readme.cr)[src/readme.cr]
readme file processor
TODO: add pattern filter
TODO: add file type filter
TODO: add user passed path instead of listing current
TODO: add no-recursive option
TODO: add output file redirection

