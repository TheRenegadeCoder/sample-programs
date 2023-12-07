function insertion_sort()
    %input validation
    arg_list = argv();
    nargin = length(arg_list);
    if  nargin == 0
        %if there was no input
        disp('Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"');
        return;
    end

    array_string = arg_list{1};
    array_size = sum(array_string == ',') + 1;
    if array_size < 2
        disp('Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"');
        return;
    end

    %build array
    array = str2num(array_string);
    if length(array) ~= array_size || any(mod(array, 1) ~= 0)
        disp('Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"');
        return;
    end

    %insertion sort in ascending order
    for i = 2:array_size
        d = i;
        while d > 1 && array(d) < array(d-1)
            temp = array(d);
            array(d) = array(d-1);
            array(d-1) = temp;
            d = d - 1;
        end
    end

    %convert to string
    result_string = num2str(array);

    %replace space with ', '
    result_string = regexprep(result_string, '\s+', ', ');
    disp(result_string);
end
