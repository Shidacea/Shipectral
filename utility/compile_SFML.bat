cd %1
cd sfml

cmake -DCMAKE_CXX_COMPILER="cl" -DCMAKE_C_COMPILER="cl" -DCMAKE_INSTALL_PREFIX="%CD%" %2
cmake --build . --target install --config Release