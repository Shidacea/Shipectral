@set CRYSTAL_PATH=%CD%\third_party\crystal\src;%CD%\build
@set PATH=%PATH%;%CD%\third_party\crystal\src;%CD%\%1\sfml\bin
@set LIB=%LIB%;%CD%\third_party\crystal\src;%CD%\%1\sfml\lib;%PATH%
@set INCLUDE=%INCLUDE%;%CD%\third_party\SFML\include

crystal build src\Shipectral.cr -o %1\shipectral\Shipectral.exe --error-trace > log.txt
