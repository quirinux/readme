.ONESHELL:
.PHONY: README.md changelog
DOCKER_USER := quirinux
DOCKER_REPO := readme
VERSION := ${shell cat Cargo.toml | grep version | head -1 | grep -o -e "[0-9]\.[0-9]\.[0-9]"}
BIN := ${shell cat Cargo.toml | grep name | head -1 | grep -o -e "\".*\"" | sed -e s/\"//g}
DOCKER_CONTEXT := .
ARGS := 
TAG = v${VERSION}
TARGET := debug
README := ./target/${TARGET}/${BIN}

run:
	cargo run -- ${ARGS}

build:
	cargo build ${ARGS}

build.release:
	${MAKE} build ARGS=--release TARGET=release
	${MAKE} strip TARGET=release

strip:
	strip ${README}

docker.build:
	docker build -t ${DOCKER_USER}/${DOCKER_REPO}:${VERSION} ${DOCKER_CONTEXT}
	docker tag ${DOCKER_USER}/${DOCKER_REPO}:${VERSION} ${DOCKER_USER}/${DOCKER_REPO}:latest

docker.push:
	docker push ${DOCKER_USER}/${DOCKER_REPO}:${VERSION}
	docker push ${DOCKER_USER}/${DOCKER_REPO}:latest

README.md:
	${README} --help > ./templates/HELP.txt
	${README} --template ./templates/README.md.hbs > README.md

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
	@echo ${VERSION}

changelog: 
	nvim changelog/${TAG}.md
