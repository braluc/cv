build:
	pandoc cv-template.html \
	--metadata-file=data/person.jsonld \
	--template=cv-template.html \
	--standalone \
	--embed-resources \
	--output publish/index.html

watch: build
	while true; do \
		inotifywait -rq ./icons ./data ./cv-* ; \
		make build; \
	done

clean:
	rm publish/*
