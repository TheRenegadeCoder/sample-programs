program factorial
   use, intrinsic :: iso_fortran_env, only: int64
   implicit none

   character(len=64) :: arg
   integer :: ios
   integer(kind=int64) :: n, i

   if (command_argument_count() /= 1) call usage()

   call get_command_argument(1, arg)
   arg = adjustl(trim(arg))
   if (len_trim(arg) == 0) call usage()

   read(arg, *, iostat=ios) n
   if (ios /= 0 .or. n < 0_int64) call usage()

   write(*,'(i0)') product((/(i, i = 1_int64, n)/))

contains

   subroutine usage()
      write(*,'(a)') "Usage: please input a non-negative integer"
      stop
   end subroutine usage

end program factorial
