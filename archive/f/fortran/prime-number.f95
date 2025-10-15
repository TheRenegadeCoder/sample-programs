program prime_check
   implicit none
   integer :: argc, ios, i
   character(len=256) :: arg
   integer :: number

   argc = command_argument_count()
   if (argc /= 1) call usage()

   call get_command_argument(1, arg)
   arg = adjustl(trim(arg))
   if (len_trim(arg) == 0) call usage()

   do i = 1, len_trim(arg)
      if (arg(i:i) < '0' .or. arg(i:i) > '9') call usage()
   end do

   read(arg, *, iostat=ios) number
   if (ios /= 0 .or. number < 0) call usage()

   if (is_prime(number)) then
      print *, "Prime"
   else
      print *, "Composite"
   end if

contains
   subroutine usage()
      print *, "Usage: please input a non-negative integer"
      stop
   end subroutine usage

   pure function is_prime(n) result(prime)
      integer, intent(in) :: n
      logical :: prime
      integer :: k, w, offsets(8)

      ! Wheel offsets for 30k + {1,7,11,13,17,19,23,29}
      offsets = [1, 7, 11, 13, 17, 19, 23, 29]

      if (n < 2) then
         prime = .false.
         return
      elseif (n <= 3) then
         prime = .true.
         return
      elseif (mod(n,2) == 0 .or. mod(n,3) == 0 .or. mod(n,5) == 0) then
         prime = .false.
         return
      end if

      prime = .true.
      w = 0
      k = 7   ! start from the first wheel candidate after 5

      do while (k*k <= n)
         do w = 1, 8
            if (mod(n, k + offsets(w) - 1) == 0) then
               prime = .false.
               return
            end if
         end do
         k = k + 30
      end do

   end function is_prime

end program prime_check
