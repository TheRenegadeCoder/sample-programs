program baklava
   implicit none
   integer :: i, size, spaces, stars

   parameter (size = 10)

   do i = 0, size
      spaces = size - i
      stars  = i * 2 + 1
      print '(A)', repeat(' ', spaces)//repeat('*', stars)
   end do

   do i = size-1, 0, -1
      spaces = size - i
      stars  = i * 2 + 1
      print '(A)', repeat(' ', spaces)//repeat('*', stars)
   end do
end program baklava
