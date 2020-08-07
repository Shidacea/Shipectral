project(Shipectral)
cmake_minimum_required(VERSION 3.15)

add_executable(Shipectral utility/fake.cpp)

add_custom_target(SFML_BINDINGS
	WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
	COMMAND utility/Compile_SFML_Windows.bat
)

add_custom_target(ShipectralReal ALL
	WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
	COMMAND cd third_party/anyolite && rake build_shard && cd ../..
	COMMAND utility/Compile_Shipectral_Windows.bat
	COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/third_party/SFML/bin/sfml-audio-2.dll ${CMAKE_BINARY_DIR}/sfml-audio-2.dll
	COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/third_party/SFML/bin/sfml-graphics-2.dll ${CMAKE_BINARY_DIR}/sfml-graphics-2.dll
	COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/third_party/SFML/bin/sfml-network-2.dll ${CMAKE_BINARY_DIR}/sfml-network-2.dll
	COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/third_party/SFML/bin/sfml-system-2.dll ${CMAKE_BINARY_DIR}/sfml-system-2.dll
	COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/third_party/SFML/bin/sfml-window-2.dll ${CMAKE_BINARY_DIR}/sfml-window-2.dll
	COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/third_party/SFML/bin/openal32.dll ${CMAKE_BINARY_DIR}/openal32.dll
	COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/bin/Shipectral.exe ${CMAKE_BINARY_DIR}/Shipectral.exe
	DEPENDS SFML_BINDINGS Shipectral
)
