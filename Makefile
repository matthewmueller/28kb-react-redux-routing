development: install
	@NODE_PATH=lib PORT=5000 ./node_modules/.bin/scooby index.js --open

install:
	@npm install

build:
	@NODE_PATH=lib ./node_modules/.bin/scooby index.js

minify: build/index.js
	@curl -s \
		-d compilation_level=SIMPLE_OPTIMIZATIONS \
		-d output_format=text \
		-d output_info=compiled_code \
		--data-urlencode "js_code@$<" \
		http://closure-compiler.appspot.com/compile \
		> $<.tmp
	@mv $<.tmp build/index.min.js
	@gzip -c build/index.min.js > build/index.min.js.gz

dist: install build minify
