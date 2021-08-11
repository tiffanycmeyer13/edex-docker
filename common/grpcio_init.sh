#!/bin/bash

# bash script to install gRPC stuff

# install gRPC stuff
pip3 install --upgrade pip
pip3 install grpcio
pip3 install grpcio-tools

# get proto files and generate code
PROTO_LOC="https://raw.githubusercontent.com/Unidata/netcdf-java/develop/gcdm/src/main/proto/ucar/gcdm/"
PROTOS=("gcdm_grid" "gcdm_netcdf" "gcdm_server")

# create local proto folder
cd /
mkdir -p /grpc/ucar/gcdm/ 

# download protos
for proto_type in "${PROTOS[@]}"; do
        curl ${PROTO_LOC}${proto_type}.proto -L -o /grpc/ucar/gcdm/${proto_type}.proto
done

# generate proto code
for proto_type in "${PROTOS[@]}"; do
    python3 -m grpc_tools.protoc -I/grpc/ --python_out=/grpc --grpc_python_out=/grpc /grpc/ucar/gcdm/${proto_type}.proto
done
