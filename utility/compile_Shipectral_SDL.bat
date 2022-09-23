@set CRYSTAL_PATH=%5;%CD%\%1
@set PATH=%PATH%;%5;%CD%\%1\sdllib\SDL2-2.24.0\lib\x64;%CD%\%1\sdllib\SDL2_mixer-2.6.2\lib\x64;%CD%\%1\sdllib\SDL2_image-2.6.2\lib\x64;%CD%\%1\sdllib\SDL2_ttf-2.20.1\lib\x64
@set LIB=%LIB%;%5;%CD%\%1\sdllib\SDL2-2.24.0\lib\x64;%CD%\%1\sdllib\SDL2_mixer-2.6.2\lib\x64;%CD%\%1\sdllib\SDL2_image-2.6.2\lib\x64;%CD%\%1\sdllib\SDL2_ttf-2.20.1\lib\x64;%CD%\%1\imgui-sfml;%PATH%
@set INCLUDE=%INCLUDE%;%CD%\%1\sdllib\SDL2-2.24.0\include;%CD%\%1\sdllib\SDL2_mixer-2.6.2\include;%CD%\%1\sdllib\SDL2_image-2.6.2\include;%CD%\%1\sdllib\SDL2_ttf-2.20.1\include

crystal build src\Shipectral.cr -o %1\%4\%2.exe %3 --error-trace > %1\log.txt
