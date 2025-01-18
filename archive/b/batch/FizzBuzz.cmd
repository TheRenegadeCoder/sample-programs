@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

for /l %%i in (1,1,100) do (
    set /A "m3=%%i %% 3"
    set /A "m5=%%i %% 5"
    set /A "m15=%%i %% 15"

    if !m15! equ 0 (
        echo FizzBuzz
    ) else if !m3! equ 0 (
        echo Fizz
    ) else if !m5! equ 0 (
        echo Buzz
    ) else (
        echo %%i
    )
)

ENDLOCAL
