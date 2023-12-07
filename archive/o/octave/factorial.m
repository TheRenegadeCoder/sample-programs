function factorial()
    usage = 'Usage: please input a non-negative integer';
    arg_list = argv();
    nargin = length(arg_list);
    if nargin == 0
        disp(usage);
        return;
    end

    n = str2num(arg_list{1});
    if length(n) ~= 1 || mod(n, 1) ~= 0 || n < 0
        disp(usage);
        return;
    end

    x = 1;
    for i = 1:n
        x = x * i;
    end

    disp(x);
end
