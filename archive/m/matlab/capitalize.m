function capString = capitalize(string)
    if(nargin==0)
        fprintf("Usage: please provide a string\n");
    else
        if(strlength(string)==0)
            fprintf("Usage: please provide a string\n");
        else
            string = char(string);
            capString = convertCharsToStrings(strcat(upper(string(1:1)),string(2:end)));
        end
    end
end