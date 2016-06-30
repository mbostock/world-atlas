TOPOJSON = node_modules/.bin/topojson
TOPOMERGE = node_modules/.bin/topojson-merge

all:

europe-50m: shp/europe_50m_admin_0_countries/europe_50m_admin_0_countries.shp
	mkdir -p topo
	$(TOPOJSON) \
		--quantization 1e5 \
		--id-property=+iso_n3 \
		-- countries=shp/europe_50m_admin_0_countries/europe_50m_admin_0_countries.shp \
		| $(TOPOMERGE) \
			-o topo/europe-50m.json \
			--io=countries \
			--oo=land \
			--no-key

nielsen-dma: shp/nielsen-dma/nielsen-dma.shp
	mkdir -p topo
	$(TOPOJSON) \
		--quantization 1e5 \
		--id-property=+iso_n3 \
		-- countries=shp/nielsen-dma/nielsen-dma.shp \
		| $(TOPOMERGE) \
			-o topo/nielsen-dma.json \
			--io=countries \
			--oo=land \
			--no-key

usa-states-50m: shp/usa-states-50m/usa-states-50m.shp
	mkdir -p topo
	$(TOPOJSON) \
		--quantization 1e5 \
		--id-property=iso_3166_2 \
		-p name \
		-- usa_states=shp/usa-states-50m/usa-states-50m.shp \
		| $(TOPOMERGE) \
			--io=usa_states \
			--oo=land \
			--no-key \
			| python -mjson.tool > topo/usa-states-50m.json
