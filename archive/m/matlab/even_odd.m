function result_string= odd_even(number)

%number - input by user
%result_string - output determined by this program
   
if (nargin==0)
    %if there was no input
    result_string = 'please input a number';
elseif ~isnumeric(number) || mod(number,1) ~= 0
    %check whether input is a number
    %also check if input is an integer
    result_string = 'please input a number';
else
    if mod(number,2) == 0
        result_string = 'Even';
    else
        result_string = 'Odd';
    end
end
end
        