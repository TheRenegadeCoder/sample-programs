! In program name, - is not allowed
! works until 184 (Stop is not implemented)
program fibonacci

! Create the variables
Character(26) :: low = 'abcdefghijklmnopqrstuvwxyz'                 ! Defines all lowercase letters. This is used to later scan for letters in the input as a test.
Character(26) :: cap = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'                 ! Defines all uppercase letters. This is used to later scan for letters in the input as a test.
integer(kind = 16) :: previousnumber, currentnumber, addednumber, uppers, lowers
character(len = 60) :: message                                      ! Defines the length of a message. This is used exclusively for the prompt.
character(len=10) :: argument                                       ! Defines the object we will be recieving. It will arrive as a charcters as the expectation is keyboard input.

! Tests to make sure we have recieved NUMBERS and not anything else. These act as flags that will later end the program.
uppers = scan(argument, cap)    ! This will look for uppercase letters in the recieved string
lowers = scan(argument, low)    ! This will look for lowercase letters in the recieved string

! Define the variables.
previousnumber = 0
currentnumber = 1
addednumber = 0
message = "Usage: please input the count of fibonacci numbers to output"
print *, message   ! Request from user
read *, arguement  ! Input from user      

! Enter a loop
do i = 1, arguement
    print *, i, ": ", currentnumber                 ! Print current iteration, and current number
    addednumber = previousnumber + currentnumber    ! Replace the value of 'added number' with both 'current number' and 'previous number'
    previousnumber = currentnumber                  ! Replace the value of 'previous number' with 'current number'
    currentnumber = addednumber                     ! Replace the value of 'current number' with 'added number'
end do

end program fibonacci