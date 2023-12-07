function prime_number()
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

    isprime = 0;
    if n == 2
        isprime = 1;
    elseif n < 2 || rem(n, 2) == 0
        isprime = 0;
    else
        isprime = 1;
        q = sqrt(n);
        m = 3;
        while m <= q
            if rem(n, m) == 0
                isprime = 0;
                break;
            end
            m = m + 2;
        end
    end

    if isprime == 1
        disp('prime');
    else
        disp('composite');
    end
end
