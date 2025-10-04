function fibonacci()
    usage = 'Usage: please input the count of fibonacci numbers to output';
    arg_list = argv();
    nargin = length(arg_list);
    if nargin == 0
        disp(usage);
        return;
    end

    n = str2num(arg_list{1});
    if length(n) ~= 1 || mod(n, 1) ~= 0
        disp(usage);
        return;
    end

    a(1) = 1;
    a(2) = 1;

    for i=1:n
        a(i+2) = a(i+1) + a(i);
        printf('%d: %d\n', i, a(i));
    end
end
