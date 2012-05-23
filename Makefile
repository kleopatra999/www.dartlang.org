CURRENT_BRANCH=$(shell git branch --no-color | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')

clean:
	rm -rf ./build

build: copy add_version

copy:
	rm -rf ./build && cd ./src/site && jekyll --no-server --no-auto && cd ../.. && cp -R ./src/appengine/* build/

add_version:
	ruby -p -i -e '$$_.gsub!(/CHANGEME/, "$(CURRENT_BRANCH)")' ./build/app.yaml

deploy: build
	cd ./build && appcfg.py update .

server:
	@open http://localhost:8080/ && cd ./src/site && jekyll && cd ../..

optimize:
	@find . -iname *.png | xargs -L 1 optipng -o7

o2:
	@find . -iname *.png | xargs -L 1 optipng -o2
