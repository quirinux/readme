.PHONY: README.md
ARGS := --debug
TAG = v${shell shards version}
.ONESHELL:

run:
	shards run -- ${ARGS}

build:
	shards build ${ARGS}

build.release:
	${MAKE} build ARGS="--production --release --static --no-debug"
	strip ./bin/readme

README.md:
	./bin/readme --help > ./templates/HELP.txt.j2
	./bin/readme --template ./templates/README.md.j2 > README.md

git-me:
	if [ -d "/__w/readme/readme" ]; then
		git config --global --add safe.directory /__w/readme/readme
		git config --global user.name 'Github Action'
		git config --global user.email 'workflow@users.noreply.github.com'
	fi
	git add . || exit 0
	git commit -m "Automated README.md" || exit 0
	git push || exit 0

tag-me:
	git tag -a ${TAG} -m "Tagging release ${TAG}"
	git tag
	git push origin --tags

version:
	@shards version

changelog/%: 
	echo "Empty release note" > $@
