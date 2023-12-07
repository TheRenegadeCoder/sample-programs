function capitalize()
    arg_list = argv();
    nargin = length(arg_list);
    if nargin==0
        disp("Usage: please provide a string");
        return;
    end

    string = arg_list{1};
    if length(string) == 0
        disp("Usage: please provide a string");
        return;
    end

    disp(strcat(upper(string(1:1)),string(2:end)));
end
