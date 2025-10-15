program fizzbuzz
   implicit none
   integer, parameter :: n = 100
   integer :: i

   do i = 1, n
      write(*,'(A)') fizzbuzz_string(i)
   end do

contains

   pure function fizzbuzz_string(x) result(str)
      integer, intent(in) :: x
      character(len=8) :: str

      str = ''

      if (mod(x,3) == 0) str = 'Fizz'
      if (mod(x,5) == 0) str = trim(str)//'Buzz'
      if (len_trim(str) == 0) write(str,'(I0)') x
   end function fizzbuzz_string

end program fizzbuzz
