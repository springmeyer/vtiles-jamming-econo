# vector tiles jamming econo

This tutorial seeks to demonstrate concepts and best practices for creating vector tiles locally and making things with them at [low cost](http://en.wikipedia.org/wiki/We_Jam_Econo) and without depending on online services when a local or hands-on scriptable method readily exists.

This tutorial uses OSM coastlines since they are simple and foundational OSM data. This is a sandbox for ideas that should blossom into formal Mapbox tutorials in due time.

## Depends

 - Node.js v0.10.x
 - TileMill 2 - `npm install` from `master` branch of https://github.com/mapbox/tm2
 - Tessera - `npm install tessera -g`
 - `unzip` command (`apt-get install unzip`)
 - Water polygons from http://openstreetmapdata.com/data/water-polygons

## Setup

    git clone https://github.com/mapbox/tm2
    cd tm2
    npm install
    cd ../
    git clone https://github.com/springmeyer/vtiles-jamming-econo
    cd vtiles-jamming-econo
    wget http://data.openstreetmapdata.com/water-polygons-split-3857.zip
    unzip water-polygons-split-3857.zip

## The Flow

We assume you've taken the time to understand TM2 concepts of a "source" and "style". This project contains two pre-created TM2 projects of these two types that both reference `water-polygons-split-3857/water_polygons.shp`:

  - source.tm2: describes a source of VT to be created from `water_polygons.shp`.
  - styles.tm2: describes a source of image tiles that visually render the data using the `source.tm2` source of vector tiles.

### Setup

Open `source.tm2/data.yml` and edit `/Users/dane/projects/water-polygons/water-polygons-split-3857/water_polygons.shp` and change it to an absolute path that matches your location.

Open `style.tm2/project.yml` and edit `tmsource:///Users/dane/projects/water-polygons/source.tm2` and change it to an absolute path that matches your location.

TODO: support relative paths in TM2 to avoid this problem?

### Render a set Vector Tiles into a mbtiles file

From the `vtiles-jamming-econo` directory (assuming `../tm2` checkout exists):

    XML_SOURCE=/Users/dane/projects/water-polygons/source.tm2/data.xml
    MBTILES_SINK=/Users/dane/projects/water-polygons/export.mbtiles

    ../tm2/node_modules/tilelive/bin/copy \
    bridge://${XML_SOURCE} \
    mbtiles://${MBTILES_SINK} \
    --minzoom=0 \
    --maxzoom=2 \
    --bbox=-180,-60,180,60

### Render a set image tiles into an mbtiles from the vector tiles in mbtiles

TODO: not yet possible / need to finish this section

MBTILES_SOURCE=/Users/dane/projects/water-polygons/export.mbtiles

./node_modules/tilelive/bin/copy \
mbtiles://${MBTILES_SOURCE} \
vector://TODO \
--minzoom=0 \
--maxzoom=2 \
--bbox=-180,-60,180,60

### Use Tessera

TODO:

```
one server:
  - tessera mbtiles://./export.mbtiles
  - or cd source.tm2 && tessera tmsource://./
other:
  - edit style.tm2/project.yml # change source to source: "tilejson+http://localhost:8080/index.json"
  - cd style.tm2 && PORT=8081 tessera
```
