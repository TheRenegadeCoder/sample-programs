path = "output.txt";

% Write content to file
file = fopen(path,'w');
if file == -1
    fprintf(strcat(path, " does not exist\n"));
    return;
end
fprintf(file, "Hello, World!\n");
fprintf(file, "Goodbye!\n");
fclose(file);

% Read content from file
file = fopen(path,'r');
if file == -1
    fprintf(strcat(path, " does not exist\n"));
    return;
end
a = fgetl(file);
while ischar(a)
    disp(a);
    a = fgetl(file);
end
fclose(file);
