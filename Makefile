
ARGS :=

all:
	shards build --release

run:
	shards run -- ${ARGS}
