program capitalize
   implicit none
   character(len=100) :: cmd
   integer :: argc

   argc = command_argument_count()
   if (argc /= 1) call usage()

   call get_command_argument(1, cmd)
   cmd = adjustl(trim(cmd))
   if (len_trim(cmd) == 0) call usage()

   cmd(1:1) = upper(cmd(1:1))

   write(*,*) cmd

contains

   subroutine usage()
      write(*,*) "Usage: please provide a string"
      stop
   end subroutine

   pure elemental function upper(str) result(string)
      character(*), intent(in) :: str
      character(len(str)) :: string
      integer :: i, iend
      integer, parameter :: toupper = iachar('A') - iachar('a')

      iend = len_trim(str)
      string = str(:iend)

      do concurrent (i = 1:iend)
         select case (str(i:i))
          case ('a':'z')
            string(i:i) = achar(iachar(str(i:i)) + toupper)
         end select
      end do
   end function upper

end program capitalize
