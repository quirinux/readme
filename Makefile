.PHONY: README.md
ARGS :=

all:
	shards build --release

run:
	shards run -- ${ARGS}

build:
	shards build --release

README.md:
	./bin/readme --template README.md.j2 > README.md
