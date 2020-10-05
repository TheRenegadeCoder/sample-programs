MODULE PrintHelloWorld;

FROM InOut IMPORT WriteString, WriteLn;

BEGIN
	WriteString('Hello world!');
	WriteLn;
END PrintHelloWorld.

