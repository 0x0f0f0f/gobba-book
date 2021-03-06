.PHONY: default build deploy

default: build

build:
	mdbook build

deploy: book
	git add -A && \
	git commit -m "deployed on $(shell date) by ${USER}" && \
	git push origin master
	@echo "====> deploying to github"
	git worktree add /tmp/book gh-pages
	rm -rf /tmp/book/*
	cp -rp book/* /tmp/book/
	cd /tmp/book && \
		git add -A && \
		git commit -m "deployed on $(shell date) by ${USER}" && \
		git push origin gh-pages
	git worktree remove /tmp/book