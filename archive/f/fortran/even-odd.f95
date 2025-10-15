program evenodd
   implicit none
   character(len=12) :: arg
   character(len=52) :: letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
   integer :: number, ios, argc

   argc = command_argument_count()
   if (argc /= 1) call usage()

   call get_command_argument(1, arg)
   if (len_trim(arg) == 0) call usage()
   if (scan(arg, letters) > 0) call usage()

   read(arg, *, iostat=ios) number
   if (ios /= 0) call usage()

   if (mod(number,2) == 0) then
      write(*,*) "Even"
   else
      write(*,*) "Odd"
   end if

contains

   subroutine usage()
      write(*,*) "Usage: please input a number"
      stop
   end subroutine

end program evenodd
