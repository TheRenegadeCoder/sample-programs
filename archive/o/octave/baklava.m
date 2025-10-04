function baklava()
    for n = -10:10
        num_spaces = abs(n);
        num_stars = 21 - 2 * num_spaces;
        disp([repmat(' ', 1, num_spaces), repmat('*', 1, num_stars)]);
    end
end
