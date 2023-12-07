function selection_sort()
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

    %selection sort in ascending order
    sorted = [];
    while ~isempty(array)
        x = min(array);
        sorted = [ sorted array(array==x) ];
        array(array==x) = [];  
    end

    %convert to string
    result_string = num2str(sorted);

    %replace space with ', '
    result_string = regexprep(result_string, '\s+', ', ');
    disp(result_string);
end
