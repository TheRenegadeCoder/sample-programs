program insertionsort
    implicit none
    character(len=256) input1
    character(len=256) output
    character(len=10) :: integer_number
    integer, allocatable :: numbers(:)
    integer :: i
    
    if(command_argument_count() /= 1) call usage()
    call get_command_argument(1, input1)
    if(input1 == "") call usage()
    call convert_to_array(input1, numbers)
    
    if(size(numbers) == 1) call usage()
    
    call insertion_sort(numbers)
    
    output = ""
    do i = 1, size(numbers)
        write(integer_number, '(I0)') numbers(i)
        if(len_trim(output) == 0) then
            output = trim(integer_number)
        else
            output = trim(output) // ", " // trim(integer_number)
        end if
    end do
    print '(A)', trim(output)
    
    
contains
    subroutine usage()
        write(*,'(a)') 'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"'
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
            if (io_status /= 0) call usage()
            pos = index(input1(pos:), ',') + pos
        end do
    end subroutine convert_to_array
    
    subroutine insertion_sort(numbers)
        implicit none
        integer, intent(inout) :: numbers(:)
        integer :: i, j, temp
        
        do i = 2, size(numbers)
            temp = numbers(i)
            j = i - 1
            
            do while (j >= 0 .and. numbers(j) > temp)
                numbers(j+1) = numbers(j)
                j = j - 1
            end do
            numbers(j+1) = temp
        end do
        
    end subroutine insertion_sort
end program insertionsort