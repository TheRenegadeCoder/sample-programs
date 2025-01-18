@echo off

rem Reference: https://rosettacode.org/wiki/Loops/For#Batch_File
SETLOCAL ENABLEDELAYEDEXPANSION

for /l %%n in (0,1,20) do (
    rem num_spaces = abs(n - 10)
    set /a "num_spaces=%%n-10"
    if !num_spaces! lss 0 set /a "num_spaces=10-%%n"

    rem num_stars = 21 - 2 * num_spaces
    set /a "num_stars=21-(2*!num_spaces!)"

    rem Get num_spaces " "
    set "line="
    if !num_spaces! gtr 0 (
        for /l %%i in (1,1,!num_spaces!) do set "line=!line! "
    )

    rem Append num_stars "*"
    for /l %%i in (1,1,!num_stars!) do set "line=!line!*"

    rem Output line
    echo !line!
)

ENDLOCAL
