LIBRARY_PATH=":$(pwd)/lib/imgui-sfml" crystal build src/Shipectral.cr -o $1/shipectral/Shipectral --error-trace > log.txt