! In program name, - is not allowed
!works till 77
! 78 and above is out of the reasonable bounds for calculation
program factorial_generate
  character(len=10) :: argument
  Character(26) :: low = 'abcdefghijklmnopqrstuvwxyz'
  Character(26) :: cap = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  integer :: number, check_capital_letters, check_small_letters, i
  integer(kind = 16):: factorial
  ! Anything not equal to single argument, Print Error
  IF(COMMAND_ARGUMENT_COUNT().NE.1)THEN
    write(*,'(g0.8)')"Usage: please input a non-negative integer"
    STOP
  ENDIF
  
  CALL GET_COMMAND_ARGUMENT(1,argument)
  if (argument == "") then
    write(*,'(g0.8)')"Usage: please input a non-negative integer"
    STOP
  endif
  ! Scan for letters
  check_capital_letters = scan(argument, cap)
  check_small_letters = scan(argument, low)
  ! If capital letters exist, print error
  if (check_capital_letters > 0) then
    write(*,'(g0.8)')"Usage: please input a non-negative integer"
    STOP
  endif
  ! If small letters exist, print error
  if (check_small_letters > 0) then
    write(*,'(g0.8)')"Usage: please input a non-negative integer"
    STOP
  endif
  ! read the cmd line arg into number
  read (argument, '(I10)') number

  if (number < 0) then
    write(*,'(g0.8)')"Usage: please input a non-negative integer"
    STOP
  endif
  if (number > 77) then
    write(*,'(g0.8)')"Input is out of the reasonable bounds for calculation"
    STOP
  endif

  factorial = 1
  do i = 1, number
    factorial = factorial * i
  end do
  write(*,'(g0.8)') factorial
end program
