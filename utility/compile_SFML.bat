cd %1
cd sfml

cmake -DCMAKE_INSTALL_PREFIX="%CD%" ..\..\third_party\SFML
cmake --build . --target install --config Release