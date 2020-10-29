! In program name, - is not allowed
program evenodd
character(len=10) :: argument
Character(26) :: low = 'abcdefghijklmnopqrstuvwxyz'
Character(26) :: cap = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
integer :: number, check_capital_letters, check_small_letters, remainder 
! Anything not equal to single argument, Print Error
IF(COMMAND_ARGUMENT_COUNT().NE.1)THEN
  write(*,'(g0.8)')"Usage: please input a number"
  STOP
ENDIF

CALL GET_COMMAND_ARGUMENT(1,argument)
if (argument == "") then
  write(*,'(g0.8)')"Usage: please input a number"
  STOP
endif
! Scan for letters
check_capital_letters = scan(argument, cap)
check_small_letters = scan(argument, low)
! If capital letters exist, print error
if (check_capital_letters > 0) then
  write(*,'(g0.8)')"Usage: please input a number"
  STOP
endif
! If small letters exist, print error
if (check_small_letters > 0) then
  write(*,'(g0.8)')"Usage: please input a number"
  STOP
endif
! read the cmd line arg into number
read (argument, '(I10)') number
! get the remainder
remainder = modulo(number, 2)
if (remainder == 0) then
  write(*,'(g0.8)') "Even"
else
  write(*,'(g0.8)') "Odd"
end if
end program
