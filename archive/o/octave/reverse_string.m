function reverse_string()
    arg_list = argv();
    nargin = length(arg_list);
    if nargin ~= 0
        disp(fliplr(arg_list{1}));
    end
end
