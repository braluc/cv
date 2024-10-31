.PHONY: build watch clean

build:
	pandoc main.html \
	--metadata-file=main.json \
	--template=main.html \
	--standalone \
	--embed-resources \
	--output docs/index.html

watch: build
	while true; do \
		inotifywait -rq ./templates ./content ./vendor ./main.* ; \
		make build; \
	done

clean:
	rm docs/index.html
