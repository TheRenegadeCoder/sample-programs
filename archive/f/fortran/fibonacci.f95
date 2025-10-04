! In program name, - is not allowed
! works until 184 (Stop is not implemented)
program fibonacci

! Create the variables
character(26) :: low = 'abcdefghijklmnopqrstuvwxyz'                 ! Defines all lowercase letters. This is used to later scan for letters in the input as a test.
character(26) :: cap = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'                 ! Defines all uppercase letters. This is used to later scan for letters in the input as a test.
integer(kind = 16) :: previousnumber, currentnumber, addednumber, uppers, lowers, loop
character(len=10) :: argument                                      ! Defines the object we will be recieving. It will arrive as a charcters as the expectation is keyboard input.
                                                                   ! Fortran knows that 'argument' is user input, so we never need to set it to anything

! Define variables.
previousnumber = 0
currentnumber = 1
addednumber = 0

IF(COMMAND_ARGUMENT_COUNT().NE.1)THEN
    write(*,'(g0.8)')"Usage: please input the count of fibonacci numbers to output"
    STOP
ENDIF
  
CALL GET_COMMAND_ARGUMENT(1,argument)
    if (argument == "") then
    write(*,'(g0.8)')"Usage: please input the count of fibonacci numbers to output"
    STOP
endif

! Tests to make sure we have recieved NUMBERS and not anything else. These act as flags that will later end the program.
uppers = scan(argument, cap)    ! This will look for uppercase letters in the recieved string. If any letter is uppercase, uppers will be updated.
lowers = scan(argument, low)    ! This will look for lowercase letters in the recieved string. If any letter is lowercase, lowers will be updated.

! Will see if there are any uppercase, if so, print an error.
if (uppers > 0) then            
  write(*,'(g0.8)')"Usage: please input the count of fibonacci numbers to output"
  STOP
endif

! Will see if there are any lowercase, if so, print an error.
if (lowers > 0) then            
  write(*,'(g0.8)')"Usage: please input the count of fibonacci numbers to output"
  STOP
endif


! If all checks pass, we will enter this section.  If non pass, we will not reach this point
! Enter a loop
read (argument, '(I10)') loop
do i = 1, loop
    write(*,'(5g0)') i, ": ", currentnumber         ! Print current iteration, and current number
    addednumber = previousnumber + currentnumber    ! Replace the value of 'added number' with both 'current number' and 'previous number'
    previousnumber = currentnumber                  ! Replace the value of 'previous number' with 'current number'
    currentnumber = addednumber                     ! Replace the value of 'current number' with 'added number'
end do

end program fibonacci