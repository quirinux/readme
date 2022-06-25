.ONESHELL:
.PHONY: README.md
DOCKER_USER := quirinux
DOCKER_REPO := readme
VERSION := ${shell shards version}
DOCKER_CONTEXT := .
ARGS := --debug
TAG = v${VERSION}

run:
	shards run -- ${ARGS}

build:
	shards build ${ARGS}

build.release:
	${MAKE} build ARGS="--production --release --static --no-debug"
	strip ./bin/readme

docker.build:
	docker build -t ${DOCKER_USER}/${DOCKER_REPO}:${VERSION} ${DOCKER_CONTEXT}
	docker tag ${DOCKER_USER}/${DOCKER_REPO}:${VERSION} ${DOCKER_USER}/${DOCKER_REPO}:latest

docker.push:
	docker push ${DOCKER_USER}/${DOCKER_REPO}:${VERSION}
	docker push ${DOCKER_USER}/${DOCKER_REPO}:latest

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

retag:
	git tag -d ${TAG}
	git push origin --tags
	${MAKE} tag-me TAG=${TAG}

version:
	@shards version

changelog/%: 
	echo "Empty release note" > $@
