.PHONY: build watch clean
.DEFAULT_GOAL := build

docs/skill-weights.json: filters/skill-weights.jq main.json
	jq -f ./filters/skill-weights.jq main.json > docs/skill-weights.json

docs/skill-ratios.json: filters/skill-ratios.jq docs/skill-weights.json
	jq -f ./filters/skill-ratios.jq docs/skill-weights.json > docs/skill-ratios.json

docs/responsibility-weights.json: filters/responsibility-weights.jq main.json
	jq -f ./filters/responsibility-weights.jq main.json > docs/responsibility-weights.json

docs/responsibility-ratios.json: filters/responsibility-ratios.jq docs/responsibility-weights.json
	jq -f ./filters/responsibility-ratios.jq docs/responsibility-weights.json > docs/responsibility-ratios.json

prebuild: docs/skill-ratios.json docs/responsibility-ratios.json

build: prebuild main.json
	pandoc main.html \
	--metadata-file=main.json \
	--metadata-file=docs/skill-ratios.json \
	--metadata-file=docs/responsibility-ratios.json \
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
	rm docs/skill-weights.json
	rm docs/skill-ratios.json
	rm docs/index.html
