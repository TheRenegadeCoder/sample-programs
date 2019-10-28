function result_string= bubble_sort(array_string)

%array_string - string containing unsorted input
%result_string - sorted result 

%input validation
if (nargin==0)
    %if there was no input
    result_string = 'please provide a list of at least two integers to sort in the format “1, 2, 3, 4, 5”';
    return
elseif length(array_string)<2
    result_string = 'please provide a list of at least two integers to sort in the format “1, 2, 3, 4, 5”';  
    return
else
    %build array
    
    %replace all spaces with empty character
    array_string(isspace(array_string)) = [];
    array = [];
    count = 1;
    %iterate over the string, increment index by 2
    for i = 2:2:length(array_string)
        
        if ~isnumeric(str2double((array_string(i-1)))) || ...
                array_string(i)~=','
            result_string = 'please provide a list of at least two integers to sort in the format “1, 2, 3, 4, 5”';
            return
        else   
            array(count) = str2double(array_string(i-1));
            count= count + 1;
        end
        
        %add the last number
        
        if isnumeric(str2double((array_string(length(array_string)))))
            array(count) = str2double(array_string(length(array_string)));
        else
            result_string = ...
                'please provide a list of at least two integers to sort in the format “1, 2, 3, 4, 5”';
        end
    end    
          
end

%to keep track of whether any changes have been made on each pass
flag = 1;

while flag==1
    flag = 0;
    for i = 1:length(array)-1
        if array(i)>array(i+1)
            temp = array(i+1);
            array(i+1) = array(i);
            array(i) = temp;
            flag = 1;
        end
    end
end


%convert to string
result_string = num2str(array);
    %replace space with ', '
    result_string = regexprep(result_string, '\s+', ', ');


end
