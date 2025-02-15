! In program name, - is not allowed
! works until 184 (Stop is not implemented)
program fibonacci

! Create the variables
character(26) :: low = 'abcdefghijklmnopqrstuvwxyz'                 ! Defines all lowercase letters. This is used to later scan for letters in the input as a test.
character(26) :: cap = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'                 ! Defines all uppercase letters. This is used to later scan for letters in the input as a test.
character(10) :: numbers = '0123456789'                             ! Defomes all numbers.
integer(kind = 16) :: previousnumber, currentnumber, addednumber, uppers, lowers, nums
character(len = 60) :: message                                      ! Defines the length of a message. This is used exclusively for the prompt.
character(len=10) :: argument                                       ! Defines the object we will be recieving. It will arrive as a charcters as the expectation is keyboard input.

! Define the variables.
previousnumber = 0
currentnumber = 1
addednumber = 0
message = "Usage: please input the count of fibonacci numbers to output"
print *, message   ! Request from user
read *, arguement  ! Input from user   

! Tests to make sure we have recieved NUMBERS and not anything else. These act as flags that will later end the program.
uppers = scan(argument, cap)    ! This will look for uppercase letters in the recieved string. If any letter is uppercase, uppers will be updated.
lowers = scan(argument, low)    ! This will look for lowercase letters in the recieved string. If any letter is lowercase, lowers will be updated.
nums = scan(arguement, numbers) ! This will look for numbers in the recieved string. If any letter is a number, the nums be updated.

! Will see if there are any uppercase, if so, print an error.
if (uppers > 0) then            
  print *, message
  STOP
endif

! Will see if there are any lowercase, if so, print an error.
if (lowers > 0) then            
  print *, message
  STOP
endif

! Will see if there are any numbers, if there are not, print a error.
if (nums > 0) then            
  print *, message
  STOP
endif


! If all checks pass, we will enter this section.  If non pass, we will not reach this point
! Enter a loop
do i = 1, arguement
    print *, i, ": ", currentnumber                 ! Print current iteration, and current number
    addednumber = previousnumber + currentnumber    ! Replace the value of 'added number' with both 'current number' and 'previous number'
    previousnumber = currentnumber                  ! Replace the value of 'previous number' with 'current number'
    currentnumber = addednumber                     ! Replace the value of 'current number' with 'added number'
end do

end program fibonacci