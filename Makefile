.PHONY: all deps compile shell clean

SHELL := BASH_ENV=.rc /bin/bash --noprofile

all: deps compile

deps:
	mix deps.get

compile:
	mix compile
	
shell:
	DOCKER_RUN_EXTRA_OPTS="-e SLACK_APP_TOKEN -e SLACK_BOT_TOKEN" iex -S mix

clean:
	mix clean --all
	mix deps.clean --all
