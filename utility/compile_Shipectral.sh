LIBRARY_PATH=":$(pwd)/lib/imgui-sfml" crystal build src/Shipectral.cr -o $1/shipectral/$2 $3 --error-trace > log.txt