# Swiss Municipality Maps

Generate [TopoJSON](https://github.com/mbostock/topojson) maps of Swiss municipalities
for  [OneGov/onegov.election_day](https://github.com/OneGov/onegov.election_day) 
from publicly available [swisstopo](https://www.swisstopo.admin.ch) geodata.

This repository is based of the apparently now abandonded [interactivethings/swiss-maps](https://github.com/interactivethings/swiss-maps).

## Getting Started

To generate the TopoJSON files you need to install Node.js, either with the [official Node.js installer](http://nodejs.org/) or via [Homebrew](http://mxcl.github.io/homebrew/):

    brew install node

You also need GDAL and the corresponding python-gdal library installed. Links to the binaries are in the [GDAL Wiki](http://trac.osgeo.org/gdal/wiki/DownloadingGdalBinaries). On OS X you can also use Homebrew:

    brew install gdal

On Ubuntu/Mint Linux run the following to install `gdal`

    sudo add-apt-repository ppa:ubuntugis/ppa && sudo apt-get update
    sudo apt-get install -y gdal-bin
    ogr2ogr --version

Or install qgis according to the their documentation. It includes gdal as well.

## Data needed

- `V200` is used as the outer boundaries of Switzerland
- `swissBOUNDARIES3D` is the database, which will be used to extract Shapefiles
  by a database query with the aid of the `gdal` package. They are then processed
  with node modules to create the TopoJson.

The `generate` script does the following:

- cleans `build`, `topo` and `svg` temporary folder
- Run `make all YEAR=2021` which will 

Run `generate` script after you obtained the raw data and put it in `src/`:

    ./generate 2018

## Explanations

Shapefiles are not really used anymore, they are considered to be a limited,
old format introduced by ESRI, creators of ArcGIS. Since 2020, seantis creates the 
topojson with the aid of a FileGeoDatabase (gdb). The scripts still have to 
create shapefiles in order to convert them to TopoJson, though.

- [Data Downlaod](https://shop.swisstopo.admin.ch/en/products/landscape/boundaries3D)

## Resources

- https://gdal.org/drivers/vector/gpkg.html
- https://medium.com/@GispoFinland/learn-spatial-sql-and-master-geopackage-with-qgis-3-16b1e17f0291

GeoJSON: Section 4 of RFC7946 tells us that

> The coordinate reference system for all GeoJSON coordinates is a geographic coordinate 
> reference system, using the World Geodetic System 1984 (WGS 84) [WGS84] datum, 
> with longitude > and latitude units of decimal degrees. This is equivalent to the coordinate 
> reference system > identified by the Open Geospatial Consortium (OGC) URN urn:ogc:def:crs:OGC::CRS84
    
    ogr2ogr -sql "select * from TLM_HOHEITSGEBIET where ICC = 'CH'" -f GPKG boundaries.gpkg swissBOUNDARIES3D_1_3_LV03_LN02.gdb

Test a single two first builds:
    
    make clean
    make build/ch/municipalities.shp PROPERTIES=id,name YEAR=2020
    make build/zh/municipalities.shp PROPERTIES=id,name YEAR=2020
    
The outputted GeoJson does not have correct swiss coordinates.

## Copyright and License

### Author

Jeremy Stucki, [Interactive Things](http://interactivethings.com)

### Data Source

Data source is the Swiss Federal Office of Topography, [swissBOUNDARIES3D](http://www.swisstopo.admin.ch/internet/swisstopo/en/home/products/landscape/swissBOUNDARIES3D.html) 2015-2018.

### License

* Geodata from swisstopo is licensed under the [Licence for the free geodata of the Federal Office of Topography swisstopo](LICENSE-GEODATA)
* Everything else: [BSD](LICENSE)
