program fibonacci
   implicit none
   integer(kind=8) :: prev, curr, next, n, i
   character(len=32) :: arg
   integer :: ios

   if (command_argument_count() /= 1) then
      call usage()
      return
   endif

   call get_command_argument(1, arg)
   arg = adjustl(trim(arg))
   if (len_trim(arg) == 0) then
      call usage()
      return
   endif

   read(arg, *, iostat=ios) n
   if (ios /= 0 .or. n < 0) then
      call usage()
      return
   endif

   if (n == 0) return

   prev = 0
   curr = 1

   do i = 1, n
      write(*,'(I0,": ",I0)') i, curr
      next = prev + curr
      prev = curr
      curr = next
   end do

contains

   subroutine usage()
      write(*,'(A)') "Usage: please input the count of fibonacci numbers to output"
   end subroutine usage

end program fibonacci
