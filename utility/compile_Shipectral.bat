git clone https://github.com/crystal-lang/crystal %CD%\build\crystal

set CRYSTAL_PATH=%CD%\build\crystal\src;%CD%\build
set PATH=%PATH%;%CD%\build\crystal\src;%CD%\%1\sfml\bin
set LIB=%LIB%;%CD%\build\crystal\src;%CD%\%1\sfml\lib;%PATH%
set INCLUDE=%INCLUDE%;%CD%\third_party\SFML\include

crystal build src\Shipectral.cr -o %1\shipectral\Shipectral.exe
