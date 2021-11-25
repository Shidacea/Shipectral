@set CRYSTAL_PATH=%CD%\third_party\crystal\src;%CD%\build
@set PATH=%PATH%;%CD%\third_party\crystal\src
@set LIB=%LIB%;%CD%\third_party\crystal\src;%PATH%

crystal build src\Shipectral.cr -o %1\shipectral\%2.exe %3 --error-trace > log.txt
