path = "output.txt";

% Write content to file
file = fopen(path,'w');
if file == -1
    fprintf(strcat(path, " does not exist\n"));
    return
end
fprintf(file, "Hello, World!\n");
fclose(file);

% Read content from file
file = fopen(path,'r');
if file == -1
    fprintf(strcat(path, " does not exist\n"));
    return
end
a = fscanf(file,'%s');
fprintf(a)


