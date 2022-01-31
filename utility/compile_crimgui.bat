@set INCLUDE=%INCLUDE%;%CD%\third_party\SFML\include
@set LIB=%LIB%;%2;%CD%\%1\sfml\lib;%PATH%

@cd %1
@cd imgui-sfml

@cd cimgui

cmake -DCMAKE_CXX_COMPILER="cl" -DCMAKE_C_COMPILER="cl" -DCMAKE_CXX_FLAGS='-DIMGUI_USE_WCHAR32' .
cmake --build . 

@cd ..

make