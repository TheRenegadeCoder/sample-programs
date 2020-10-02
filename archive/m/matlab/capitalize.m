function capString = capitalize(string)
    string = char(string);
    capString = convertCharsToStrings(strcat(upper(string(1:1)),string(2:end)));
end