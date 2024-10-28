build:
	pandoc cv-template.html \
	--metadata-file=data/person.jsonld \
	--template=cv-template.html \
	--standalone \
	--embed-resources \
	--output publish/index.html

clean:
	rm publish/*
