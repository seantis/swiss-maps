# Swiss Municipality Maps

Generate [TopoJSON](https://github.com/mbostock/topojson) maps of Swiss municipalities
for [OneGov/onegov.election_day](https://github.com/OneGov/onegov.election_day)
from publicly available [swisstopo](https://www.swisstopo.admin.ch) geodata.
Generate corresponding json data for the naming of the districts and communities.
This repository is based of the apparently now abandonded [interactivethings/swiss-maps](https://github.com/interactivethings/swiss-maps).

## Prequisites

To generate the TopoJSON files you need to install Node.js, either with the 
[official Node.js installer](http://nodejs.org/) or via [Homebrew](http://mxcl.github.io/homebrew/):

    brew install node

You also need GDAL and the corresponding python-gdal library installed. 
Links to the binaries are in the [GDAL Wiki](http://trac.osgeo.org/gdal/wiki/DownloadingGdalBinaries). 
On OS X you can also use Homebrew:

    brew install gdal

On Ubuntu/Mint Linux run the following to install `gdal`:

    # gdal might be present, try
    sudo apt install gdal-bin
  
    # For Ubuntu
    sudo add-apt-repository ppa:ubuntugis/ppa && sudo apt-get update
    sudo apt-get install -y gdal-bin
    ogr2ogr --version

Or install qgis according to the documentation. It includes gdal as well.

## Scripts

Run `generate` directly to create all municipalities and rename the files:

    ./generate 2018

## Create municipalities json files

This is related to [seantis/swiss-municipalities](https://github.com/seantis/swiss-municipalities). 
For the sake of consistency, we can generate the same files out of the geodata 
without using another data source. Together with the TopoJson, they can be used
for naming the districts. The data looks like this:

```
{
  "90": {
    "district": "Dielsdorf"
    "name": "Niederhasli"
  },
  ...
}
```
Where `"90"` is the BSF-Nr. which corresponds to the `id` in the TopoJson.
Use the script `generate_municipalties` to create the json files.

## Copyright and License

### Author

Jeremy Stucki, [Interactive Things](http://interactivethings.com)

### Data Source

Data source is the Swiss Federal Office of Topography, [swissBOUNDARIES3D](https://shop.swisstopo.admin.ch/en/products/landscape/boundaries3D).

### License

* Geodata from swisstopo is licensed [here](https://www.swisstopo.admin.ch/de/home/meta/conditions.html)
* Everything else: [BSD](LICENSE)
