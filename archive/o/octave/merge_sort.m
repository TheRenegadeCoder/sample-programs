function merge_sort()
    %input validation
    usage = 'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"';
    arg_list = argv();
    nargin = length(arg_list);
    if  nargin == 0
        %if there was no input
        disp(usage);
        return;
    end

    array_string = arg_list{1};
    array_size = sum(array_string == ',') + 1;
    if array_size < 2
        disp(usage);
        return;
    end

    %build array
    array = str2num(array_string);
    if length(array) ~= array_size || any(mod(array, 1) ~= 0)
        disp(usage);
        return;
    end

    %merge sort in ascending order
    array = MyMergeSort(array);

    %convert to string
    result_string = num2str(array);

    %replace space with ', '
    result_string = regexprep(result_string, '\s+', ', ');
    disp(result_string);
end

function [result] = MyMergeSort( x )
    % Sort vector 'x' using the merge sort algorithm
    % result is a vector consisting of the sorted values of 'x' 
    % in ascended order
    % Takes O( n log n ) time
    % Requires extra memory for merging results

    n = length(x);
    if n == 1
        % Stop the recursion, if we are down to one element in list
        result = x;
    else
        m = floor(n/2);  % Get the half way point

        r1 = MyMergeSort( x(1:m) );    % Sort first half recursively...
        r2 = MyMergeSort( x(m+1:n) );  % Sort 2nd half recursively...
        result = MyMerge( r1, r2 );    % Merge the two halves in sorted order
    end
end

function c = MyMerge( a, b )
    % Merges 2 vectors a,b into a result vector c 
    %   assumes a, b are already sorted
    %   'c' will also be in sorted order

    aLen = length(a);  % get length of a
    bLen = length(b);  % get length of b
    cLen = aLen+bLen;
    c = zeros(1,cLen); % pre-allocate 'c' to correct size

    % Initialize starting indices
    aIdx = 1;
    bIdx = 1;
    for cIdx = 1:cLen
        % Should we grab from 'a' or 'b' ???
        if aIdx > aLen
            % All done with 'a' vector, grab from 'b' vector.
            c(cIdx) = b(bIdx); 
            bIdx = bIdx + 1;
        elseif bIdx > bLen
            % All done with 'b' vector, grab from 'a' vector
            c(cIdx) = a(aIdx); 
            aIdx = aIdx + 1;
        elseif a(aIdx) <= b(bIdx)
            % a(i) <= b(i), grab from 'a' vector
            c(cIdx) = a(aIdx); 
            aIdx = aIdx + 1;
        else
            % b(i) < a(i), grab from 'b' vector
            c(cIdx) = b(bIdx); 
            bIdx = bIdx + 1;
        end
    end
end

% BY - Nikhil Gupta
% GitHub - nikkkhil067
