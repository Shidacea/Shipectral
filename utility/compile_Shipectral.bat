@set CRYSTAL_PATH=%CD%\third_party\crystal\src;%CD%\%1
@set PATH=%PATH%;%CD%\third_party\crystal\src;%CD%\%1\sfml\bin
@set LIB=%LIB%;%CD%\third_party\crystal\src;%CD%\%1\sfml\lib;%CD%\%1\imgui-sfml;%PATH%
@set INCLUDE=%INCLUDE%;%CD%\third_party\SFML\include

crystal build src\Shipectral.cr -o %1\%4\%2.exe %3 --error-trace > %1\log.txt
