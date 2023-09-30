#!/bin/bash

data_path="$1"

pushd $data_path

filename="spain-latest"
pbf_file="$filename.osm.pbf"
osrm_file="$filename.osrm"

docker run --rm -t -v "${PWD}:/data" osrm/osrm-backend osrm-extract -p /opt/car.lua /data/$pbf_file
docker run --rm -t -v "${PWD}:/data" osrm/osrm-backend osrm-partition /data/$osrm_file
# docker run -t -v "${PWD}:/data" osrm/osrm-backend osrm-customize /data/$osrm_file

# Launch
# docker run -t -i -p 5000:5000 -v "${PWD}:/data" osrm/osrm-backend osrm-routed --algorithm mld /data/berlin-latest.osrm
