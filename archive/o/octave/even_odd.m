function even_odd()
    arg_list = argv();
    nargin = length(arg_list);
    if (nargin==0)
        %if there was no input
        disp('Usage: please input a number');
    else
        number = str2num(arg_list{1});
        if length(number) ~= 1 || mod(number, 1) ~= 0
            %check whether input is a number
            %also check if input is an integer
            disp('Usage: please input a number');
        else
            if mod(number, 2) == 0
                disp('Even');
            else
                disp('Odd');
            end
        end
    end
end
