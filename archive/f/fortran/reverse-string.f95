program reverse_string
   implicit none
   character(len=:), allocatable :: arg, rev
   integer :: i, n, error

   if (command_argument_count() < 1) then
      print '("")'
      stop
   end if

   ! Get length of argument
   call get_command_argument(1, length=n, status=error)
   if (error /= 0 .or. n == 0) then
      print '("")'
      stop
   end if

   ! Allocate and read argument
   allocate(character(len=n) :: arg)
   call get_command_argument(1, arg, status=error)
   if (error /= 0) then
      print '("")'
      deallocate(arg)
      stop 0
   end if

   ! Allocate and create reversed string
   allocate(character(len=n) :: rev)
   do i = 1, n
      rev(i:i) = arg(n-i+1:n-i+1)
   end do

   print '(A)', rev
end program reverse_string
