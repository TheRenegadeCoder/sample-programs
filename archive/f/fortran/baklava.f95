program Baklava
    do i = 0, 9, 1
        print *, repeat (" ", (10 - i)), repeat ("*", (i * 2 + 1))
    end do
    do i = 10, 0, -1
        print *, repeat (" ", (10 - i)), repeat ("*", (i * 2 + 1))
    end do
end program Baklava