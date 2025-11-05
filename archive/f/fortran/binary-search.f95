program binarysearch
    implicit none
    character(len=256) :: input1
    character(len=10) :: input2
    integer :: key, left, right, middle, io_status, i, length, pos
    integer, allocatable :: numbers(:)
    logical :: searched
    
    if(command_argument_count() < 2) call usage()
    
    call get_command_argument(1, input1)
    call get_command_argument(2,input2)
    
    if(input1 == "") call usage()
    
    call convert_to_array(input1, numbers)
    
    read(input2, fmt=*, iostat=io_status) key
    
    do i = 1, size(numbers) - 1
      if(numbers(i) > numbers(i+1)) then
       call usage()
      end if
    end do

    left = 1
    right = size(numbers)
    searched = binary_search(numbers,key, left, right)
    if (searched) then
        print '(a)', 'true'
    else
        print '(a)', 'false'
    end if
    
contains
    subroutine usage()
      write(*,'(a)') "Usage: please provide a list of sorted integers (""1, 4, 5, 11, 12"") and the integer to find (""11"")"
      stop
    end subroutine usage
    
    subroutine convert_to_array(input1, numbers)
        implicit none
        character(len=*), intent(in) :: input1
        integer, allocatable, intent(out) :: numbers(:)
        integer :: i, length, pos, io_status
        
        length = 1
        do i = 1, len_trim(input1)
            if (input1(i:i) == ',') length = length + 1
        end do
    
        allocate(numbers(length))
    
        pos = 1
        do i = 1, length
            read(input1(pos:), *, iostat=io_status) numbers(i)
            pos = index(input1(pos:), ',') + pos
        end do
    end subroutine convert_to_array

    function binary_search(numbers, key, left, right) result(answer)
      implicit none
      logical :: answer
      integer, intent(in) :: key
      integer, intent(in) :: numbers(:)
      integer :: left
      integer :: right
      integer :: middle
      answer = .false.
      do while (left <= right)
        middle = (left + right) / 2
        if(numbers(middle) == key) then
          answer = .true.
          return
        else if(numbers(middle) > key) then
          right = middle - 1
        else
          left = middle + 1
        end if
      end do
    end function binary_search
end program binarysearch