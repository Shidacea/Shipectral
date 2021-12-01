@set CRYSTAL_PATH=%CD%\third_party\crystal\src;%CD%\%1
@set PATH=%PATH%;%CD%\third_party\crystal\src
@set LIB=%LIB%;%CD%\third_party\crystal\src;%PATH%

crystal build src\Shipectral.cr -o %1\%4\%2.exe %3 --error-trace > log.txt
