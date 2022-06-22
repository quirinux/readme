.PHONY: README.md
ARGS :=

all:
	shards build --release

run:
	shards run -- ${ARGS}

build:
	shards build --production --release --static --no-debug
	strip ./bin/readme

README.md:
	./bin/readme --template README.md.j2 > README.md
