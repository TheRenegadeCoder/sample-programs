Program linearsearch
    implicit none

    character(len=256) :: input1
    character(len=10) :: input2
    integer :: key
    integer, dimension(5) :: array
    logical :: searched
    integer :: io_status

    if(command_argument_count() < 2) call usage()

    call get_command_argument(1, input1)
    call get_command_argument(2,input2)

    if(input1 == "") call usage()

    read(unit=input1, fmt=*, iostat=io_status) array
    read(unit=input2, fmt=*, iostat=io_status) key
    
    searched = exists(array,key)

    if (searched) then
        print '(a)', 'true'
    else
        print '(a)', 'false'
    end if

    contains

    pure function exists(array, key) result(answer)
        implicit none
        INTEGER :: i
        integer, intent(in) :: key
        integer, intent(in) :: array(:)
        logical :: answer

        answer = .false.

        do i = 1, size(array), 1
            if(array(i) == key) then
                answer = .true.
                return
            end if
        end do

    end function exists

subroutine usage()
    write(*,'(a)') "Usage: please provide a list of integers (""1, 4, 5, 11, 12"") and the integer to find (""11"")"
    stop
end subroutine usage

End Program linearsearch