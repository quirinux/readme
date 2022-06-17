.PHONY: README.md
ARGS :=

all:
	shards build --release

run:
	shards run -- ${ARGS}

build:
	shards build --release

README.md:
	cat HEADER.md > README.md
	./bin/readme >> README.md
