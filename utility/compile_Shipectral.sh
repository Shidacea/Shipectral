LIBRARY_PATH=":$(pwd)/lib/imgui-sfml" crystal build src/Shipectral.cr -o $1/$4/$2 $3 --error-trace > $1/log.txt