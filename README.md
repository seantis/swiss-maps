# Swiss Municipality Maps

Generate [TopoJSON](https://github.com/mbostock/topojson) maps of Swiss municipalities for  [OneGov/onegov.election_day](https://github.com/OneGov/onegov.election_day) from publicly available [swisstopo](https://www.swisstopo.admin.ch) geodata.

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

To get started, clone this repository and run `generate`.

    git clone https://github.com/interactivethings/swiss-maps.git
    cd swiss-maps
    ./generate 2018

## Copyright and License

### Author

Jeremy Stucki, [Interactive Things](http://interactivethings.com)

### Data Source

Data source is the Swiss Federal Office of Topography, [swissBOUNDARIES3D](http://www.swisstopo.admin.ch/internet/swisstopo/en/home/products/landscape/swissBOUNDARIES3D.html) 2015-2018.

### License

* Geodata from swisstopo is licensed under the [Licence for the free geodata of the Federal Office of Topography swisstopo](LICENSE-GEODATA)
* Everything else: [BSD](LICENSE)

### Current Development

This repository will be maintained in the future. We will likely go the way to not use ESRI Shapefiles in the future anymore for obvious reasons.
Data in the open standard OBMS is already provided by Swisstopo. For the lack of finding other libraries capable of reading Geopackages to create the desired Topojson/GeoJson from we still convert it to a shapefile.
