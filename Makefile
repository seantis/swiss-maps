YEAR = 2018
PROPERTIES = id,name
CANTONS = \
	zh be lu ur sz ow nw gl zg \
	fr so bs bl sh ar ai sg gr \
	ag tg ti vd vs ne ge ju
WIDTH = 960
HEIGHT = 500
MARGIN = 10
SIMPLIFY = $(if $(REPROJECT),1e-9,.5)

BUILD_FILE = municipalities.shp
SOURCE_DIR = src/V200

ifeq ($(shell test $(YEAR) -gt 2015; echo $$?),0)
  VEC = VECTOR200_HOHEITSGEBIET.shp
else
  VEC = VEC200_Commune.shp
endif

ifeq ($(shell test $(YEAR) -gt 2019; echo $$?),0)
	VEC = swissBOUNDARIES3D_1_3_LV03_LN02.gdb
	SOURCE_DIR = src/swissBOUNDARIES3D
	# BUILD_FILE = swiss_boundaries.gpkg
endif

ifeq ($(shell test $(YEAR) -gt 2021; echo $$?),0)
	VEC = swissBOUNDARIES3D_1_3_LV95_LN02.gdb
	SOURCE_DIR = src/swissBOUNDARIES3D
endif

all: node_modules \
	$(addprefix topo/,$(addsuffix -municipalities.json,$(CANTONS)))

node_modules: package.json
	npm install
	touch $@

# Clean generated files
clean:
	rm -rf build topo svg

##################################################
# Boundaries and lakes
##################################################
build/ch/$(BUILD_FILE): $(SOURCE_DIR)/$(YEAR)/$(VEC)
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr $(if $(REPROJECT),-t_srs EPSG:4326 -s_srs EPSG:21781) -sql "select * from TLM_HOHEITSGEBIET where ICC = 'CH' and BFS_NUMMER < 9000" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr $(if $(REPROJECT),-t_srs EPSG:4326 -s_srs EPSG:21781) -where "CAST(BFS_NUMMER as integer(4)) > 0 AND CAST(BFS_NUMMER as integer(4)) < 9000" -f 'ESRI Shapefile' $@ $<; \
	else \
		ogr2ogr $(if $(REPROJECT),-t_srs EPSG:4326 -s_srs EPSG:21781) -where "COUNTRY = 'CH'" $@ $<; \
	fi

build/zh/$(BUILD_FILE): build/ch/municipalities.shp
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '1'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH01000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 1 AND SEENR = 0" $@ $<; \
	fi

build/be/$(BUILD_FILE): build/ch/municipalities.shp
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '2'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH02000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 2 AND SEENR = 0" $@ $<; \
	fi

build/lu/$(BUILD_FILE): build/ch/municipalities.shp
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '3'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH03000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 3 AND SEENR = 0" $@ $<; \
	fi

build/ur/$(BUILD_FILE): build/ch/municipalities.shp
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '4'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH04000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 4 AND SEENR = 0" $@ $<; \
	fi

build/sz/$(BUILD_FILE): build/ch/municipalities.shp
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '5'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH05000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 5 AND SEENR = 0" $@ $<; \
	fi

build/ow/$(BUILD_FILE): build/ch/municipalities.shp
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '6'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH06000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 6 AND SEENR = 0" $@ $<; \
	fi

build/nw/$(BUILD_FILE): build/ch/municipalities.shp
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '7'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH07000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 7 AND SEENR = 0" $@ $<; \
	fi

build/gl/$(BUILD_FILE): build/ch/municipalities.shp
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '8'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH08000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 8 AND SEENR = 0" $@ $<; \
	fi

build/zg/$(BUILD_FILE): build/ch/municipalities.shp
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '9'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH09000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 9 AND SEENR = 0" $@ $<; \
	fi

build/fr/$(BUILD_FILE): build/ch/municipalities.shp
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '10'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH10000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 10 AND SEENR = 0" $@ $<; \
	fi

build/so/$(BUILD_FILE): build/ch/municipalities.shp
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '11'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH11000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 11 AND SEENR = 0" $@ $<; \
	fi

build/bs/$(BUILD_FILE): build/ch/municipalities.shp
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '12'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH12000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 12 AND SEENR = 0" $@ $<; \
	fi

build/bl/$(BUILD_FILE): build/ch/$(BUILD_FILE)
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '13'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH13000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 13 AND SEENR = 0" $@ $<; \
	fi

build/sh/$(BUILD_FILE): build/ch/$(BUILD_FILE)
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '14'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH14000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 14 AND SEENR = 0" $@ $<; \
	fi

build/ar/$(BUILD_FILE): build/ch/$(BUILD_FILE)
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '15'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH15000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 15 AND SEENR = 0" $@ $<; \
	fi

build/ai/$(BUILD_FILE): build/ch/$(BUILD_FILE)
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '16'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH16000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 16 AND SEENR = 0" $@ $<; \
	fi

build/sg/$(BUILD_FILE): build/ch/$(BUILD_FILE)
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '17'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH17000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 17 AND SEENR = 0" $@ $<; \
	fi

build/gr/$(BUILD_FILE): build/ch/$(BUILD_FILE)
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '18'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH18000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 18 AND SEENR = 0" $@ $<; \
	fi

build/ag/$(BUILD_FILE): build/ch/$(BUILD_FILE)
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '19'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH19000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 19 AND SEENR = 0" $@ $<; \
	fi

build/tg/$(BUILD_FILE): build/ch/$(BUILD_FILE)
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '20'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH20000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 20 AND SEENR = 0" $@ $<; \
	fi

build/ti/$(BUILD_FILE): build/ch/$(BUILD_FILE)
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '21'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH21000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 21 AND SEENR = 0" $@ $<; \
	fi

build/vd/$(BUILD_FILE): build/ch/$(BUILD_FILE)
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '22'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH22000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 22 AND SEENR = 0" $@ $<; \
	fi

build/vs/$(BUILD_FILE): build/ch/$(BUILD_FILE)
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '23'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH23000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 23 AND SEENR = 0" $@ $<; \
	fi

build/ne/$(BUILD_FILE): build/ch/$(BUILD_FILE)
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '24'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH24000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 24 AND SEENR = 0" $@ $<; \
	fi

build/ge/$(BUILD_FILE): build/ch/$(BUILD_FILE)
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '25'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH25000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 25 AND SEENR = 0" $@ $<; \
	fi

build/ju/$(BUILD_FILE): build/ch/$(BUILD_FILE)
	mkdir -p $(dir $@)
	rm -f $@
	if [ ${YEAR} -gt 2019 ] ; then \
		ogr2ogr -where "KANTONSNUM = '26'" -f 'ESRI Shapefile' $@ $<; \
	elif [ ${YEAR} -gt 2015 ] ; then \
		ogr2ogr -where "KANTONSNUM = 'CH26000000'" $@ $<; \
	else \
		ogr2ogr -where "KANTONSNR = 26 AND SEENR = 0" $@ $<; \
	fi

build/%-municipalities-unmerged.json: build/%/$(BUILD_FILE)
	mkdir -p $(dir $@)
	if [ ${YEAR} -gt 2015 ] ; then \
		node_modules/.bin/topojson \
			-o $@ \
			--no-quantization \
			--id-property=+BFS_NUMMER \
			-p name=NAME,id=+BFS_NUMMER \
			-- municipalities=$<; \
	else \
		node_modules/.bin/topojson \
			-o $@ \
			--no-quantization \
			--id-property=+BFSNR \
			-p name=GEMNAME,id=+BFSNR \
			-- municipalities=$<; \
	fi

build/%.json: build/%-unmerged.json
	node_modules/.bin/topojson-merge \
		-o $@ \
		--in-object=$(lastword $(subst -, ,$*)) \
		--out-object=$(lastword $(subst -, ,$*)) \
		-- $<

topo/%.json: build/%.json
	mkdir -p $(dir $@)
	node_modules/.bin/topojson \
		-o $@ \
		$(if $(REPROJECT),,--width=$(WIDTH) --height=$(HEIGHT) --margin=$(MARGIN)) \
		--no-pre-quantization \
		--post-quantization=1e5 \
		--simplify=$(SIMPLIFY) \
		$(if $(PROPERTIES),-p $(PROPERTIES),) \
		-- $<
