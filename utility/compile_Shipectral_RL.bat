@set CRYSTAL_PATH=%5;%CD%\%1
@set PATH=%PATH%;%5;%CD%\%1\raylib-cr\rsrc\native\windows\raylib\lib
@set LIB=%LIB%;%5;%CD%\%1\raylib-cr\rsrc\native\windows\raylib\lib;%PATH%
@set INCLUDE=%INCLUDE%;%CD%\%1\raylib-cr\rsrc\native\windows\raylib\include

crystal build src\Shipectral.cr -o %1\%4\%2.exe %3 --error-trace > %1\log.txt
