@set CRYSTAL_PATH=%5;%CD%\%1
@set PATH=%PATH%;%5;%CD%\%1\rl_lib\raylib-4.0.0_win64_msvc16\lib
@set LIB=%LIB%;%5;%CD%\%1\rl_lib\raylib-4.0.0_win64_msvc16\lib;%PATH%
@set INCLUDE=%INCLUDE%;%CD%\%1\rl_lib\raylib-4.0.0_win64_msvc16\include

crystal build src\Shipectral.cr -o %1\%4\%2.exe %3 --error-trace > %1\log.txt
